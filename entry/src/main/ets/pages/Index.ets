import { add, gotoPage, Index as ShareIndex } from '@ohos/library_share_common';
import router from '@ohos.router';
import { DynamicRouter, RouterInfo } from '@ohos/library_router/Index';
import { display, promptAction } from '@kit.ArkUI';

// const module = import('../../../../../library_static_common/src/main/ets/pages/Index')
// const module = import('../../../../../ability_about/src/main/ets/pages/Index')
@Entry
@Component
struct Index {
  @State message: string = 'Hello World Main';
  // Navigation路由栈,控制页面跳转
  @Provide('pageStack') pageStack: NavPathStack = DynamicRouter.navPathStack
  @Provide('fullScreenSize') fullScreenSize: string = '50%'
  @State navigationMode: NavigationMode = NavigationMode.Stack
  @State curFoldStatus: display.FoldStatus = 0
  // @State screenW: number = px2vp(display.getDefaultDisplaySync().width)
  // 依据Navigation的mode属性说明，如使用Auto，窗口宽度>=600vp时，采用Split模式显示；窗口宽度<600vp时，采用Stack模式显示。
  private readonly DeviceSize: number = 600
  // 在侧滑退出应用时，用于判断是否第二次滑动
  private  isSecondPressBack = false
  // 侧滑拦截toast提示时长
  private readonly Exit_Toast_Duration = 1800
  // 两次侧滑事件间隔时长
  private readonly Exit_Press_Back_Duration = 1000

  aboutToAppear() {
    // 注册动态router
    DynamicRouter.init()
    if(display.isFoldable()) {
      this.regDisplayListener()
    } else {
      // if(this.screenW >= this.DeviceSize) {
      //   this.navigationMode = NavigationMode.Split
      // } else {
      //   this.navigationMode = NavigationMode.Stack
      // }
    }
  }

  // 侧滑返回拦截功能：用于首页侧滑返回时，需在1秒内侧滑两次才能退出应用
  onBackPress(): boolean | void {
    if(this.isSecondPressBack) {
      return false
    } else {
      this.isSecondPressBack = true
      setTimeout(() => {
        this.isSecondPressBack = false
      }, this.Exit_Press_Back_Duration)

      promptAction.showToast({
        message: '再滑一次退出',
        duration: this.Exit_Toast_Duration
      })

      return true
    }
  }

  @Builder
  pageMap(name: string, param: ESObject) {
    NavDestination() {
      // 根据模块名，获取WrappedBuilder对象，通过builder接口创建页面
      DynamicRouter.getBuilder(name).builder(param)
    }
    // 按需将NavDestinationMode配置为DIALOG类型，此时背景默认透明
    // TODO: 弹窗设置
    .mode(NavDestinationMode.STANDARD)
    .hideTitleBar(true)
  }

  /**
   * 注册屏幕状态监听
   * @returns {void}
   */
  regDisplayListener() {
    this.changeNavigationMode(display.getFoldStatus())
    display.on('foldStatusChange', async (curFoldStatus: display.FoldStatus) => {
      // 同一个状态重复触发不做处理
      if(this.curFoldStatus == this.curFoldStatus) {
        return
      }
      // 缓存当前折叠状态
      this.curFoldStatus = curFoldStatus
      this.changeNavigationMode(this.curFoldStatus)
    })
  }

  // 更改NavigationMode
  changeNavigationMode(status: display.FoldStatus) {
    if(status == display.FoldStatus.FOLD_STATUS_FOLDED) {
      this.navigationMode = NavigationMode.Stack
    } else {
      this.navigationMode = NavigationMode.Split
    }
  }

  build() {
    Stack() {
      Navigation(this.pageStack) {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .borderColor(Color.Red)
          .borderWidth(0.5)
          .width('100%')
        Button() {
          Text('library_share_common')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .padding(10)
        .type(ButtonType.Capsule)
        // .margin(10)
        .backgroundColor('#0D9FFB')
        // .width('40%')
        // .height(40)
        .onClick(async () => {
          let result = add(1, 2);
          console.log(`-->result: ${result}`);
          let url = 'pages/Index'
          // url = '@bundle:com.lx.hw.LXHarmonyKit/library_share_common/ets/pages/Index'
          // url = '@bundle:com.lx.hw.LXHarmonyKit/ability_login/ets/pages/LoginPage'
          // url = '@bundle:com.lx.hw.LXHarmonyKit/library_static_common/ets/pages/Index'
          url = 'pages/ListPage'
          console.log(`-->start at: ${url}`)
          // await gotoPage(url)
          DynamicRouter.push(RouterInfo.library_static_common_MainPage, 'RouterInfo.library_static_common_MainPage')
          // router.pushNamedRoute({
          //   // name: 'library_static_common',
          //   name: 'ability_about'
          // })
          console.log(`-->end at: ${url}`)
        })

        ShareIndex()
      }
    }
    .height('100%')
      }
      .backgroundColor('#f1f1f1')
      .hideTitleBar(true)
      .navBarWidth(this.fullScreenSize)
      .navDestination(this.pageMap)
      .mode(this.navigationMode)
    }
    .alignContent(Alignment.BottomEnd)
    .height('100%')
    .backgroundColor('#f1f1f1')

  }
}