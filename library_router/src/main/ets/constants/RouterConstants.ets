// import { Logger } from '@ohos/library_static_common'
import { Logger } from '../utils/Logger'

export const logger = new Logger('[library_router]');

export class BuilderNameConstants {
  static readonly ability_login: string = '@ohos/ability_login';
  static readonly library_static_common: string = '@ohos/library_static_common';
  static readonly library_share_common: string = '@ohos/library_share_common';
}

export class RouterNameConstants {
  static readonly Entry_Hap = 'EntryHap_Router';
}