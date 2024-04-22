import { add, gotoPage, Index as ShareIndex } from '@ohos/library_share_common';
import router from '@ohos.router';
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/library_router/Index';

// const module = import('../../../../../library_static_common/src/main/ets/pages/Index')
// const module = import('../../../../../ability_about/src/main/ets/pages/Index')
@Entry
@Component
struct EntryIndex {
  @State message: string = 'Hello World Main';
  @State entryHapRouter: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    if(!this.entryHapRouter) {
      this.entryHapRouter = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.Entry_Hap, this.entryHapRouter);
  }

  @Builder
  routerMap(builderName: string, param: object) {
    RouterModule.getBuilder(builderName).builder(param);
  }

  build() {
    Navigation(this.entryHapRouter) {
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
          // console.log(`-->result: ${result}`);
          let url = 'pages/Index'
          // url = '@bundle:com.lx.hw.LXHarmonyKit/library_share_common/ets/pages/Index'
          // url = '@bundle:com.lx.hw.LXHarmonyKit/ability_login/ets/pages/LoginPage'
          // url = '@bundle:com.lx.hw.LXHarmonyKit/library_static_common/ets/pages/Index'
          url = 'pages/ListPage'
          // console.log(`-->start at: ${url}`)
          await gotoPage(url)
          // router.pushNamedRoute({
          //   // name: 'library_static_common',
          //   name: 'ability_about'
          // })
          // console.log(`-->end at: ${url}`)
          // buildRouterModel(RouterNameConstants.Entry_Hap, BuilderNameConstants.library_share_common, new Object({
          //   origin: 'Entry'
          // }))
        })

        ShareIndex()
      }
    }
    .height('100%')
  }
  .title('feature list')
  .navDestination(this.routerMap);
}
}