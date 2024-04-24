import { RouterInfo } from '../constants/RouterInfo'
import { Logger } from './Logger'

const logger = new Logger('[Dynamic Router]')

/**
 * 动态路由
 *
 * 实现步骤：
 * 1.将主模块的NavPathStack传入createRouter接口，注册路由
 * 2.通过registerBuilder接口，将需要动态加载的模块注册到路由中
 * 3.通过push接口，跳转到指定的模块页面
 */
export class DynamicRouter {
  // 管理需要动态导入的模块，key是模块名，value是WrappedBuilder对象，动态调用创建页面的接口
  static builderMap = new Map<string, WrappedBuilder<[object]>>()
  static navPathStack = new NavPathStack()
  // 通过数组实现自定义栈的管理
  static routerStack = new Array<RouterInfo>();
  static referrer: string[] = [];

  // 通过名称注册builder
  private static registerBuilder(builderName: string, builder: WrappedBuilder<[object]>) {
    DynamicRouter.builderMap.set(builderName, builder)
  }

  // 通过名称获取builder
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    const builder = DynamicRouter.builderMap.get(builderName)
    if(!builder) {
      logger.info(`--> ${builderName} not founded!`)
    }
    return builder as WrappedBuilder<[object]>
  }

  // 注册router
  public static init() {
    // 初始化时来源页为未定义
    const home = RouterInfo.Home
    DynamicRouter.routerStack.push(home)
    logger.info(`-->Home is: ${home.moduleName}/${home.pageName}}`)
  }

  // 通过名称获取router
  private static getNavPathStack(): NavPathStack {
    return DynamicRouter.navPathStack
  }

  // 获取路由来源页面栈
  public static getRouterReferrer(): string[] {
    return DynamicRouter.referrer;
  }

  // 通过获取页面栈跳转到指定页面
  public static async push(routerInfo: RouterInfo, param?: string, animated?: boolean): Promise<void> {
    const moduleName = routerInfo.moduleName
    const pageName = routerInfo.pageName
    // 动态加载模块是否成功
    let isImportSucceed = false
    // entry模块不需要动态加载源码
    if(routerInfo.moduleName == RouterInfo.Home.moduleName) {
      isImportSucceed = true
    } else {
      // TODO：知识点：通过动态import的方式引入模块，在需要进入页面时才加载模块，可以减少主页面的初始化时间及占用的内存
      await import(moduleName)
        // 动态加载模块成功时，通过模块中的harInit接口加载页面
        .then((result: ESObject) => {
          result.harInit(pageName)
          isImportSucceed = true
        }, (error: ESObject) => {
          // 动态加载模块失败时，打印错误日志
          logger.error(`--> ${moduleName} load failure, Error: ${error}`)
        })
    }
    if(isImportSucceed) {
      // 使用moduleName和pageName生成builderName，通过pushPath加载页面
      const builderName = `${moduleName}/${pageName}`
      // 查找到对应的路由栈进行跳转
      DynamicRouter.getNavPathStack()
        .pushPath({
          name: builderName,
          param: param
        }, animated)
      // 自定义栈也加入指定页面
      DynamicRouter.routerStack.push(routerInfo)
      const referrerModel = DynamicRouter.routerStack[DynamicRouter.routerStack.length - 2]
      DynamicRouter.referrer[0] = referrerModel.moduleName
      DynamicRouter.referrer[1] = referrerModel.pageName
      logger.info(`push succeed from (${DynamicRouter.referrer[0]}, ${DynamicRouter.referrer[1]})`)
    }
  }

  // 通过获取页面栈并pop
  public static pop(animated?: boolean) {
    // pop前记录的来源页为当前栈顶
    const referrerModel = DynamicRouter.routerStack[DynamicRouter.routerStack.length - 1]
    DynamicRouter.referrer[0] = referrerModel.moduleName
    DynamicRouter.referrer[1] = referrerModel.pageName
    logger.info(`pop page to (${DynamicRouter.referrer[0]}, ${DynamicRouter.referrer[1]})`)
    if(DynamicRouter.routerStack.length > 1) {
      DynamicRouter.routerStack.pop()
    } else {
      logger.info(`DynamicsRouter.routerStack is only Home.`)
    }
    // 查找到对应的路由栈进行pop
    DynamicRouter.getNavPathStack().pop(animated)
  }

  // 通过获取页面栈并将其清空
  public static clear() {
    // 查找到对应的路由栈进行pop
    DynamicRouter.getNavPathStack().clear()
  }

  /**
   * 注册动态路由需要加载的页面
   *
   * @param pageName 页面名，需要动态加载的页面名称
   * @param wrapBuilder wrapBuilder对象
   */
  public static registerRouterPage(routerInfo: RouterInfo, wrapBuilder: WrappedBuilder<[object]>) {
    const builderName = `${routerInfo.moduleName}/${routerInfo.pageName}`
    if(!DynamicRouter.getBuilder(builderName)) {
      DynamicRouter.registerBuilder(builderName, wrapBuilder)
    }
  }
}