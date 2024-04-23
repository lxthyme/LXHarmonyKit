import { BuilderNameConstants } from '@ohos/library_router'

export { add } from "./src/main/ets/utils/Calc"
export { Index } from "./src/main/ets/pages/Index"
export { gotoPage, back } from "./src/main/ets/plugins/RouterKit"

export function harInit(builderName: string) {
  // 动态引入要跳转的页面
  switch(builderName) {
    case BuilderNameConstants.library_share_common:
      import('./src/main/ets/components/mainpage/MainPage')
      break
    default: break
  }
}