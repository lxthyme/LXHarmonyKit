import { BuilderNameConstants, DynamicRouter,
  RouterInfo,
  RouterModule, RouterNameConstants } from '@ohos/library_router/Index';

@Component
export struct MainPage {
  @State message: string = 'Hello World library_static_common';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Builder
export function indexBuilder(value: ESObject) {
  NavDestination() {
    MainPage()
  }
  .title('library_static_common')
  .onBackPressed(() => {
    RouterModule.pop(RouterNameConstants.Entry_Hap)
    return true
  })
}

const builderName = BuilderNameConstants.library_static_common;
if(!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(indexBuilder)
  RouterModule.registerBuilder(builderName, builder)
}

// 动态路由第一次加载当前页面时调用，创建WrappedBuilder对象，并注册到路由中
DynamicRouter.registerRouterPage(RouterInfo.library_static_common_MainPage, wrapBuilder(indexBuilder))