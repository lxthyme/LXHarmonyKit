import { BuilderNameConstants } from '@ohos/library_router'

export { MainPage } from './src/main/ets/components/mainpage/MainPage'
export { Logger } from './src/main/ets/common/Logger'

export function harInit(builderName: string) {
  // 动态引入要跳转的页面
  switch(builderName) {
    case BuilderNameConstants.library_static_common:
      import('./src/main/ets/components/mainpage/MainPage')
      break
    default: break
  }
}