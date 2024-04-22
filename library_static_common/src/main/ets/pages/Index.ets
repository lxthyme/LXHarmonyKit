import { BuilderNameConstants, RouterModule, RouterNameConstants } from '@ohos/library_router';

@Entry
@Component
export struct Index {
  @State message: string = 'Hello World library_share_common';

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
export function indexBuilder(value: object) {
  NavDestination() {
    Index()
  }
  .title('library_share_common')
  .onBackPressed(() => {
    RouterModule.pop(RouterNameConstants.Entry_Hap);
    return true
  })
}

const builderName = BuilderNameConstants.library_share_common
if(!RouterModule.getBuilder(builderName)) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(indexBuilder)
  RouterModule.registerBuilder(builderName, builder)
}