import { Logger } from './../utils/Logger'

export const logger = new Logger('RouterModule')

export class BuilderNameConstants {
  static readonly HARA_A1: string = '@ohos/hara_A1';
  static readonly HARA_A2: string = '@ohos/hara_A2';
  static readonly HARA_A3: string = '@ohos/hara_A3';
  // static readonly ability_login: string = '@ohos/ability_login';
  // static readonly library_share_common = '@ohos/library_share_common';
  static readonly library_share_common = '@ohos/library_static_common';
}

export class RouterNameConstants {
  static readonly Entry_Hap = 'EntryIndex_Router';
}