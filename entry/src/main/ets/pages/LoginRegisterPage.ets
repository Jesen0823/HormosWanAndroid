import router from '@ohos.router';
import prompt from '@ohos.promptAction'
import Constants from '../common/contants/Constants';
import userAccountViewModel from '../viewmodel/UserAccountViewModel'
import { UserInfo } from '../bean/UserInfoBean';
import * as Utils from "../utils/StringUtils";
import ResponseResult from '../net/ResponseResult';

@Extend(TextInput) function inputStyle() {
  .placeholderColor($r('app.color.gray'))
  .height($r('app.float.45vp'))
  .fontSize($r('app.float.18fp'))
  .backgroundColor($r('app.color.snow'))
  .width(Constants.FULL_PARENT)
  .padding({ left: Constants.INPUT_PADDING_LEFT })
  .margin({ top: $r('app.float.12vp') })
}

@Extend(Line) function lineStyle() {
  .width(Constants.FULL_PARENT)
  .height($r('app.float.1vp'))
  .backgroundColor($r('app.color.gray'))
}

@Extend(Text) function blueTextStyle() {
  .fontColor($r('app.color.steel_blue'))
  .fontSize($r('app.float.14fp'))
  .fontWeight(FontWeight.Medium)
}

@Preview
@Entry
@Component
export default struct LoginRegisterPage {
  @State userName: string = '';
  @State passWord: string = '';
  @State rePassword: string = '';
  @State isRegister: boolean = false;
  @State isShowProgress: boolean = false;
  private timeOutId: number = -1;

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height($r('app.float.48vp'))
    .width($r('app.float.48vp'))
    .backgroundColor($r('app.color.snow'))
  }

  loginOrRegister() {
    this.isRegister ? this.doRegister() : this.doLogin()
  }

  doRegister() {
    if (this.userName === '' || this.passWord === '' || this.rePassword === '') {
      prompt.showToast({ message: $r('app.string.input_empty_tips') });
    } else {
      this.isShowProgress = true;
      userAccountViewModel.userRegister(this.userName, this.passWord, this.rePassword)
        .then(result => {
          console.log('UserInfo>>>', result)
          if (!Utils.isEmpty(result.data as UserInfo)) {
            this.delayJump()
          } else {
            this.isShowProgress = false;
            prompt.showToast({ message: result.errorMsg });
          }
        })
    }
  }

  doLogin() {
    if (this.userName === '' || this.passWord === '') {
      prompt.showToast({ message: $r('app.string.input_empty_tips') });
    } else {
      userAccountViewModel.userLogin(this.userName, this.passWord)
        .then((result: ResponseResult) => {
          console.log('login result>>>', result)
          if (!Utils.isEmpty(result.data as UserInfo)) {
            this.delayJump()
          } else {
            this.isShowProgress = false;
            prompt.showToast({ message: result.errorMsg })
          }
        });
    }
  }

  delayJump() {
    if (this.timeOutId === -1) {
      this.timeOutId = setTimeout(() => {
        this.isShowProgress = false;
        this.timeOutId = -1;
        router.replaceUrl({ url: Constants.MainPage_Path });
      }, Constants.LOGIN_DELAY_TIME);
    }
  }

  aboutToAppear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;
  }

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.Start }) {
        Image($r('app.media.ic_arrow_left_blob'))
          .size({ width: $r('app.float.30vp'), height: $r('app.float.30vp') })
          .margin({ top: $r('app.float.10vp'), right: $r('app.float.10vp') })
          .onClick(() => {
            router.back()
          })
      }

      Image($r('app.media.ic_logo'))
        .width($r('app.float.70vp'))
        .height($r('app.float.70vp'))
        .margin({ top: $r('app.float.100vp'), bottom: $r('app.float.8vp') })

      Text(this.isRegister ? $r('app.string.register_page') : $r('app.string.login_page'))
        .fontSize($r('app.float.24fp'))
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.black'))

      Text(this.isRegister ? $r('app.string.register_more') : $r('app.string.login_more'))
        .fontSize($r('app.float.16fp'))
        .fontColor($r('app.color.gray'))
        .margin({ bottom: $r('app.float.30vp'), top: $r('app.float.8vp') })

      TextInput({ placeholder: $r('app.string.account'), text: this.userName })
        .inputStyle()
        .maxLength(Constants.INPUT_ACCOUNT_LENGTH)
        .onChange((value: string) => this.userName = value)

      Line().lineStyle()

      TextInput({ placeholder: $r('app.string.password'), text: this.passWord })
        .maxLength(Constants.INPUT_PASSWORD_LENGTH)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value: string) => this.passWord = value)

      Line().lineStyle()

      if (this.isRegister) {
        TextInput({ placeholder: $r('app.string.repassword'), text: this.rePassword })
          .inputStyle()
          .maxLength(Constants.INPUT_PASSWORD_LENGTH)
          .type(InputType.Password)
          .onChange((value: string) => this.rePassword = value)
        Line().lineStyle()
      }

      Button(this.isRegister ? $r('app.string.register') : $r('app.string.login'))
        .width(Constants.BUTTON_WIDTH)
        .height($r('app.float.40vp'))
        .fontSize($r('app.float.16fp'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.dodger_blue'))
        .margin({ top: $r('app.float.87vp'), bottom: $r('app.float.12vp') })
        .onClick(() => {
          this.loginOrRegister();
        })

      Text(this.isRegister ? $r('app.string.login_account') : $r('app.string.register_account'))
        .fontColor($r('app.color.dodger_blue'))
        .fontSize($r('app.float.16fp'))
        .fontWeight(FontWeight.Medium)
        .onFocus(() => {

        })
        .onClick(() => {
          this.isRegister = !this.isRegister;
          this.userName = '';
          this.rePassword = '';
          this.passWord = '';
        })

      if (this.isShowProgress) {
        LoadingProgress()
          .color($r('app.color.slate_gray'))
          .width($r('app.float.30vp'))
          .height($r('app.float.30vp'))
          .margin({ top: $r('app.float.20vp') })
      }
    }.backgroundColor($r('app.color.snow'))
    .height(Constants.FULL_PARENT)
    .width(Constants.FULL_PARENT)
    .padding({
      left: $r('app.float.12vp'),
      right: $r('app.float.12vp'),
      bottom: $r('app.float.24vp')
    })
  }
}