import { gotoPage } from '@ohos/library_share_common';
import { getAllLibraryList } from '../vm/LibraryInfo';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { showAbilityInfo } from '@ohos/library_share_common/src/main/ets/plugins/RouterKit';
import { BuilderNameConstants, buildRouterModel,
  DynamicRouter,
  RouterInfo,
  RouterModule, RouterNameConstants } from '@ohos/library_router/Index';

@Entry
@Component
struct ListPage {
  @State currentSelectedIndex: number = 0;
  private context?: common.UIAbilityContext
  @State entryHapRouter: NavPathStack = new NavPathStack()

  // @State break
  // aboutToAppear() {
  //   this.context = getContext(this) as common.UIAbilityContext
  // }
  aboutToAppear(): void {
    this.context = getContext(this) as common.UIAbilityContext
    if(!this.entryHapRouter) {
      this.entryHapRouter = new NavPathStack()
    }
    RouterModule.createRouter(RouterNameConstants.Entry_Hap, this.entryHapRouter)
  }

  @Builder
  routerMap(builderName: string, param: object) {
    RouterModule.getBuilder(builderName)?.builder(param)
  }

  build() {
    // Row() {
    //   GridRow({
    //     breakpoints: {
    //       value: ['320vp', '600vp', '840vp'],
    //       reference: BreakpointsReference.WindowSize
    //     },
    //     columns: 1,
    //     direction: GridRowDirection.Row
    //   }) {
    //     ForEach(getAllLibraryList(), (item: string) => {
    //       GridCol({
    //         span: 1
    //       }) {
    //         Column() {
    //           this.buildListItem(item)
    //         }
    //         .width('100%')
    //         .justifyContent(FlexAlign.Start)
    //       }
    //       .width('100%')
    //     })
    //   }
    //   .width('100%')
    //   .margin({ left: 15, right: 15 })
    // }
    // .backgroundColor('#F2FAFAFA')
Navigation(this.entryHapRouter) {
    Column() {
      List() {
        LazyForEach(getAllLibraryList(), (item: string) => {
          ListItem() {
            Row() {
              Column() {
                Text(item)
                  .backgroundColor(Color.Red)
              }
              .backgroundColor(Color.Brown)
              .alignItems(HorizontalAlign.Start)
            }
          }
          .padding(10)
          .backgroundColor(Color.Orange)
          .onClick(async () => {
            if(item === 'Ability_aboutAbility') {
              DynamicRouter.push(RouterInfo.library_static_common_MainPage, 'RouterInfo.library_static_common_MainPage')
            } else if(item.includes('library_static_common')) {
              let builderName = BuilderNameConstants.library_static_common
              builderName = BuilderNameConstants.library_share_common
              builderName = `@ohos/${item}`
              buildRouterModel(RouterNameConstants.Entry_Hap, builderName, new Object({
                origin: 'Entry'
              }))
            } else {
            if(this.context){
              console.log(`-->start ${item}`)
              // let url = `@bundle:com.lx.hw.LXHarmonyKit/${item}/ets/pages/Index`
              // await gotoPage(url)
              // showAbilityInfo(this.context?.abilityInfo)
              this.context.startAbility({
                bundleName: "com.lx.hw.LXHarmonyKit",
                abilityName: item,
              }).then(() => {
                console.info('LXHarmonyKit', '-->start video ability success')
              }).catch((error: BusinessError) => {
                console.error('LXHarmonyKit', `-->start ${item}[${error.code}] failure: ${error.message}`)
              })
            }
          }
        })
      })
    }
  }
}
    .title('Entry Index')
    .navDestination(this.routerMap)
  }

  @Builder
  buildListItem(title: string) {
    Row() {
      Text(title)
    }
    .width('100%')
    .padding(10)

    // .margin({ left: 15, right: 15 })
  }
}