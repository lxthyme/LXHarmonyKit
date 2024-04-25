export class RouterInfo {
  moduleName: string = ''
  pageName: string = ''
  navMode = NavDestinationMode.STANDARD

  constructor(moduleName: string, pageName: string, navMode?: NavDestinationMode) {
    this.moduleName = moduleName
    this.pageName = pageName
    this.navMode = navMode ?? NavDestinationMode.STANDARD
  }

  static readonly Home = new RouterInfo('@ohos/entry', 'Index');
  static readonly library_static_common_MainPage = new RouterInfo('@ohos/library_static_common', 'MainPage')
}