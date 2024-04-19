import { InsightIntentExecutor, insightIntent } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

/**
 * Entry for insight intent execution.
 */
export default class IntentClassify extends InsightIntentExecutor {
  /**
   * Called when a UIAbility executes the insight intent in the foreground.
   * @param { string } intentName - Indicates the insight intent name.
   * @param { Record<string, Object> } intentParam - Indicates the insight intent parameters.
   * @param { window.WindowStage } pageLoader - Indicates the page loader.
   * @returns { Promise<insightIntent.ExecuteResult> } The result of insight intent execution.
   */
  async onExecuteInUIAbilityForegroundMode(intentName: string, intentParam: Record<string, Object>,
                                           pageLoader: window.WindowStage): Promise<insightIntent.ExecuteResult> {
    switch (intentName) {
      case 'PlayMusic':
        return this.playMusic(intentParam, pageLoader);
      case 'PlayMusicList':
        return this.playMusicList(intentParam, pageLoader);
      default:
        console.error('invalid intent name', intentName);
        let result: insightIntent.ExecuteResult = {
          code: -105,
          result: {
            "error": "invalid intent name",
            "intentName": intentName
          }
        }
        return result;
    }
  }

  /**
   * Called when a UIAbility executes the insight intent in the foreground.
   * @param { string } intentName - Indicates the insight intent name.
   * @param { Record<string, Object> } intentParam - Indicates the insight intent parameters.
   * @returns { Promise<insightIntent.ExecuteResult> } The result of insight intent execution.
   */
  async onExecuteInUIAbilityBackgroundMode(intentName: string, intentParam: Record<string, Object>):
    Promise<insightIntent.ExecuteResult> {
    switch (intentName) {
      case 'PlayMusic':
        return this.playMusic(intentParam);
      case 'PlayMusicList':
        return this.playMusicList(intentParam);
      default:
        console.error('invalid intent name', intentName);
        let result: insightIntent.ExecuteResult = {
          code: -105,
          result: {
            "error": "invalid intent name",
            "intentName": intentName
          }
        }
        return result;
    }
  }

  /**
   * Implements the PlayMusic intent.
   * @param { Record<string, Object> } intentParam - Indicates the insight intent parameters.
   * @param { window.WindowStage } pageLoader - Indicates the page loader.
   * @returns { Promise<insightIntent.ExecuteResult> } The result of insight intent execution.
   */
  private async playMusic(intentParam: Record<string, Object>, pageLoader?: window.WindowStage):
    Promise<insightIntent.ExecuteResult> {
    // TODO Implements the PlayMusic intent.
    let result: insightIntent.ExecuteResult = {
      code: 0
    }
    return result;
  }

  /**
   * Implements the PlayMusicList intent.
   * @param { Record<string, Object> } intentParam - Indicates the insight intent parameters.
   * @param { window.WindowStage } pageLoader - Indicates the page loader.
   * @returns { Promise<insightIntent.ExecuteResult> } The result of insight intent execution.
   */
  private async playMusicList(intentParam: Record<string, Object>, pageLoader?: window.WindowStage):
    Promise<insightIntent.ExecuteResult> {
    // TODO Implements the PlayMusicList intent.
    let result: insightIntent.ExecuteResult = {
      code: 0
    }
    return result;
  }
}