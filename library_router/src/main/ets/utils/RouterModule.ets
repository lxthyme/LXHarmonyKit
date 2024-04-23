// import Logger from '@ohos/library_static_common'
import { RouterModel } from '../model/RouterModel';
import { logger } from './../constants/RouterConstants'

export class RouterModule {
  static builderMap = new Map<string, WrappedBuilder<[object]>>();
  static routerMap = new Map<string, NavPathStack>();

  public static registerBuilder(builderName: string, builder: WrappedBuilder<[object]>) {
    RouterModule.builderMap.set(builderName, builder);
  }

  public static getBuilder(builderName: string): WrappedBuilder<[object]> | undefined {
    const builder = RouterModule.builderMap.get(builderName);
    if(!builder) {
      logger.info('not found builder ' + builderName);
    }
    return builder as WrappedBuilder<[object]>;
  }

  public static createRouter(routerName: string, router: NavPathStack) {
    RouterModule.routerMap.set(routerName, router);
  }

  public static getRouter(routerName: string): NavPathStack {
    return RouterModule.routerMap.get(routerName) as NavPathStack;
  }

  public static async push(router: RouterModel): Promise<void> {
    // const harName = router.builderName.split('_')[0];
    const harName = router.builderName;
    await import (harName)
      // .then((ns: ESObject): Promise<void> => ns.harInit(router.builderName));
      .then((ns: ESObject): Promise<void> => {
        logger.info(`-->[push]harInit`)
        return ns.harInit(router.builderName)
      })
      .catch((error: Error) => {
        logger.error(`-->[push]error: ${error}`)
      })
    RouterModule
      .getRouter(router.routerName)
      .pushPath({ name: router.builderName, param: router.params });
  }

  public static pop(routerName: string) {
    RouterModule.getRouter(routerName).pop();
  }

  public static clear(routerName: string) {
    RouterModule.getRouter(routerName).clear();
  }

  public static popToName(routerName: string, builderName: string) {
    RouterModule.getRouter(routerName).popToName(builderName);
  }
}