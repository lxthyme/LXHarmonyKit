import { loginComponentManager, LoginPanel, authentication } from '@kit.AccountKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { image } from '@kit.ImageKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { router } from '@kit.ArkUI';

/**
 * A page that needs the user to log Huawei account.
 * If you use this template to create a custom page, you need to config signature certificate fingerprint for it.
 */
@Entry
@Component
struct Index {
  private routerParams = router.getParams() as Record<string, image.PixelMap>;
  @State show: Resource = $r('app.string.login');
  @State isLogin: boolean = false;

  /**
   * Whether to show LoginPanel component.
   */
  @State showPanel: boolean = false;
  @State avatar: image.PixelMap | undefined = undefined;

  /**
   * Define the privacy text on LoginPanel.
   */
  privacyText: loginComponentManager.PrivacyText[] = [
    {
      text: $r('app.string.agree'),
      type: loginComponentManager.TextType.PLAIN_TEXT
    },
    {
      text: $r('app.string.privacy'),
      tag: 'privacy',
      type: loginComponentManager.TextType.RICH_TEXT
    },
    {
      text: $r('app.string.and'),
      type: loginComponentManager.TextType.PLAIN_TEXT
    },
    {
      text: $r('app.string.protocols'),
      tag: 'protocols',
      type: loginComponentManager.TextType.RICH_TEXT
    },
    {
      text: $r('app.string.end'),
      type: loginComponentManager.TextType.PLAIN_TEXT
    }
  ]

  /**
   * Construct a controller for LoginPanel.
   */
  controller: loginComponentManager.LoginPanelController = new loginComponentManager.LoginPanelController()
    .onClickLoginWithHuaweiIDButton((error: BusinessError, response: loginComponentManager.HuaweiIDCredential) => {
      hilog.info(0x0000, 'testTag', 'onClickLoginWithHuaweiIDButton');
      if (error) {
        hilog.error(0x0000, 'testTag', 'error ' + JSON.stringify(error));
        if (error.code == authentication.AuthenticationErrorCode.NETWORK_ERROR) {
          AlertDialog.show(
            {
              message: $r('app.string.hwid_no_internet_connect'),
              offset: { dx: 0, dy: -20 },
              alignment: DialogAlignment.Bottom,
              autoCancel: false,
              confirm: {
                value: $r('app.string.hwid_text_button_known'),
                action: () => {
                }
              }
            }
          )
        }
        return;
      }
      if (response) {
        hilog.info(0x0000, 'testTag', 'response ' + JSON.stringify(response));
        this.isLogin = true;
        this.showPanel = false;
        this.show = $r('app.string.dearUser');
        return;
      }
    })
    .onClickOptionalLoginButton(() => {
      hilog.info(0x0000, 'testTag', 'onClickOptionalLoginButton');
    })
    .onClickPrivacyText((error: BusinessError, tag: string) => {
      hilog.info(0x0000, 'testTag', 'onClickPrivacyText tag:' + tag);
    })
    .onClickCloseButton(() => {
      hilog.info(0x0000, 'testTag', 'onClickCloseButton');
    })

  aboutToAppear() {
    hilog.info(0x0000, 'testTag', 'aboutToAppear');
    this.silentLogin();
    this.avatar = AppStorage.get('avatar');
  }

  onPageShow(){
    hilog.info(0x0000, 'testTag', 'onPageShow');
    if (this.routerParams) {
      this.avatar = this.routerParams.avatar;
    }
  }

  private silentLogin(): void {
    hilog.info(0x0000, 'testTag', 'silentLogin');
    // new a request to login, and set the params
    let loginRequest = new authentication.HuaweiIDProvider().createLoginWithHuaweiIDRequest();
    // whether to force to pull up the Huawei account login page, when the user doesn't log Huawei account
    loginRequest.forceLogin = false;
    // execute the login request
    let controller = new authentication.AuthenticationController();
    controller.executeRequest(loginRequest).then((data) => {
      let loginWithHuaweiIDResponse = data as authentication.LoginWithHuaweiIDResponse;
      let loginWithHuaweiIDCredential = loginWithHuaweiIDResponse.data!;
      let authCode = loginWithHuaweiIDCredential.authorizationCode;
      let idToken = loginWithHuaweiIDCredential.idToken;
      let openID = loginWithHuaweiIDCredential.openID;
      let unionID = loginWithHuaweiIDCredential.unionID;

      this.isLogin = true;
      this.show = $r('app.string.dearUser');
      hilog.debug(0x0000, 'testTag', 'login success, %{public}s', JSON.stringify(loginWithHuaweiIDResponse));
    }).catch((error: BusinessError) => {
      hilog.error(0x0000, 'testTag', '%{public}s, code: %{public}d', JSON.stringify(error), error.code);
      this.show = $r('app.string.login');
      if (error.code === authentication.AuthenticationErrorCode.NETWORK_ERROR) {
        AlertDialog.show(
          {
            message: $r('app.string.hwid_no_internet_connect'),
            offset: { dx: 0, dy: -20 },
            alignment: DialogAlignment.Bottom,
            autoCancel: false,
            confirm: {
              value: $r('app.string.hwid_text_button_known'),
              action: () => {
              }
            }
          }
        )
      }
    });
  }

  build() {
    Stack() {
      Stack() {
        MainPageComponent({ isLogin: this.isLogin, show: this.show, showPanel: this.showPanel, avatar: this.avatar })
      }
      if (this.showPanel) {
        // set the params for LoginPanel component
        Stack() {
          LoginPanel({
            show: this.showPanel,
            params: {
              appInfo: {
                appIcon: $r('app.media.icon'),
                appName: $r('app.string.appName'),
                appDescription: $r('app.string.appDesc'),
              },
              privacyText: this.privacyText,
              loginType: loginComponentManager.LoginType.ID,
              optionalLoginButtonAttr: {text: $r('app.string.others')},
            },
            controller: this.controller
          })
        }
        .height('100%')
        .width('100%')
      }
    }
  }
}

@Component
struct MainPageComponent {
  @Link isLogin: boolean;
  @Link show: Resource;
  @Link showPanel: boolean;
  @Link avatar: image.PixelMap | undefined;

  aboutToAppear() {
    hilog.info(0x0000, 'testTag', 'MainPage: aboutToAppear');
  }

  build() {
    Column() {
      Row() {
        Image(this.avatar!=undefined ? this.avatar : $r('app.media.avatar'))
          .width($r('app.float.image_width'))
          .height($r('app.float.image_height'))
          .onClick(() => {
            if (this.isLogin) {
              // the developer can define the target page to jump
            } else {
              this.showPanel = true;
            }
          })
        Text(this.show)
          .fontSize($r('app.float.login_font_size'))
          .height($r('app.float.login_height'))
          .padding({ left: $r('app.float.login_padding_left') })
          .onClick(() => {
            if (this.isLogin) {
              // the developer can define the target page to jump
            } else {
              this.showPanel = true;
            }
          })
      }
      .margin({ top: $r('app.float.login_margin_top') })
      .padding({ left: $r('app.float.login_padding_left') })
      .height($r('app.float.login_area_height'))

      // the developer can define other content on this page
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.login_background'))
    .padding({ left: $r('app.float.main_padding_left'), right: $r('app.float.main_padding_right') })
    .width('100%')
    .height('100%')
  }
}