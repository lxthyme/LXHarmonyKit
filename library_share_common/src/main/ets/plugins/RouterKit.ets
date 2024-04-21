import router from '@ohos.router';
import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility } from '@kit.AbilityKit';
// import { AbilityInfo } from '../bundleManager/AbilityInfo';
import BundleManager from '@ohos.bundle.bundleManager'
// import { AbilityBase } from '@ohos.ability.ability'
// import { AbilityInfo } from '@ohos.bundle.bundleManager';
export const gotoPage = async (url: string): Promise<void> => {
  return new Promise((resolve, reject) => {
    router.pushUrl({
      url: url
    })
      .then((result) => {
        console.info(`-->go to ${url}, result: ${result}`)
        resolve(result)
      })
      .catch((error: BusinessError) => {
        console.error(`-->go to ${url} failure[1], Error[${error.code}]: ${error.message}`)
        reject(error)
      })
      .catch((error: Error) => {
        console.error(`-->go to ${url} failure[2], Error[\${error.code}]: ${error}`)
        reject(error)
      })
  })
}

export const gotoPage2 = async (url: string) => {
  const result = await router.pushUrl({ url: url })
  console.info(`-->go to ${url}, result: ${result}`)
  return result
}

export const back = () => {
  try {
    router.back()
    console.log('-->router back');
  } catch (error) {
    let code = (error as BusinessError).code;
    let message = (error as BusinessError).message;
    console.error(`-->router back failure[${code}]: ${message}`)
  }
}

export const showAbilityInfo = (abilityInfo: BundleManager.AbilityInfo | undefined) => {
  if(abilityInfo == undefined) {
    console.log(`-->abilityInfo: ${abilityInfo}`)
    return
  }
  // let base: Abili
  console.log(`
  name: ${abilityInfo.name}
  bundleName: ${abilityInfo.bundleName}
  moduleName: ${abilityInfo.moduleName}
  label[${abilityInfo.labelId}]: ${abilityInfo.label}
  description[${abilityInfo.descriptionId}]: ${abilityInfo.description}
  icon[${abilityInfo.iconId}]: ${abilityInfo.icon}
  process: ${abilityInfo.process}
  exported: ${abilityInfo.exported}
  type: ${abilityInfo.type}
  orientation: ${abilityInfo.orientation}
  launchType: ${abilityInfo.launchType}
  permissions: ${abilityInfo.permissions}
  readPermission: ${abilityInfo.readPermission}
  writePermission: ${abilityInfo.writePermission}
  uri: ${abilityInfo.uri}
  deviceTypes: ${abilityInfo.deviceTypes}
  applicationInfo: ${abilityInfo.applicationInfo}
  metadata: ${abilityInfo.metadata}
  enabled: ${abilityInfo.enabled}
  supportWindowModes: ${abilityInfo.supportWindowModes}
  windowSize: ${abilityInfo.windowSize}
`)
}

// export interface RouterKit {
//   gotoPage(url: string): Promise<void>;
//
//   back(): void;
// }
// export const RouterKit = { }