import { UserData } from '../bean/UserInfoBean'
import Logger from '../utils/Logger';
import mineViewModel from '../viewmodel/MineViewModel';
import * as Utils from "../utils/StringUtils"
import router from '@ohos.router';
import Constants from '../common/contants/Constants';
import prompt from '@ohos.promptAction';

@Preview
@Component
export default struct MineHeaderView {
  @State userData: UserData = new UserData();
  @State logined: boolean = false;
  @State rank: string = '';
  @State collectIds: string = '';
  @State level: string = '';
  @State coinCount: string = '';

  aboutToAppear() {
    mineViewModel.getUserInfo().then((data: UserData) => {
      this.userData = data;
    }).catch((e: Error) => {
      this.userData = new UserData();
      console.log('getUserInfo, error: ' + e.message);
    })
  }

  jumpLogin() {
    Logger.debug('Mine jumpLogin>>');
    router.pushUrl({
      url: Constants.LoginRegister_Path
    }, router.RouterMode.Standard, (err) => {
      if (err) {
        console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      console.info('Invoke pushUrl succeeded.');
    });
  }

  jumpPath(path: string) {
    Logger.debug('Mine jumpPath>> path',path);
    if (Utils.isEmpty(this.userData.userInfo.username)) {
      prompt.showToast({ message: '请先登录' });
      return;
    }
    console.log("jumpPath =>", path);
  }

  @Builder
  UserInfoItem(title: string, content?: string, click?: () => void) {
    Column() {
      Text(title)
        .fontSize($r('app.float.18fp'))
        .fontWeight(FontWeight.Bold)
      Text(content??"---")
        .margin({ top: $r('app.float.3vp') })
    }.flexGrow(1)
    .alignItems(HorizontalAlign.Center)
    .onClick(click)
  }

  build() {
    // 设置
    Column() {
      Flex({ alignItems: ItemAlign.Center }) {
        Text('我的')
          .textAlign(TextAlign.Center)
          .fontColor(Color.White)
          .maxLines(1)
          .fontSize($r('app.float.22fp'))
          .flexGrow(1)

        Image($r('app.media.ic_setting'))
          .size({ width: $r('app.float.30vp'), height: $r('app.float.30vp') })
          .margin({ right: $r('app.float.10vp') })
          .onClick(() => {
            router.pushUrl({ url: Constants.SettingPage_Path });
          })
      }.width(Constants.FULL_PERCENT)
      .backgroundColor($r('app.color.dodger_blue'))

      // 头像
      Column() {
        Flex({ alignItems: ItemAlign.Center }) {
          Image($r('app.media.ic_person'))
            .margin({ left: $r('app.float.20vp') })
            .size({ width: $r('app.float.60vp'), height: $r('app.float.60vp') })

          Text(Utils.isEmpty(this.userData.userInfo.username) ? $r('app.string.mine_login_wel') : this.userData.userInfo.username)
            .textAlign(TextAlign.Start)
            .maxLines(1)
            .fontSize($r('app.float.18fp'))
            .margin({ left: $r('app.float.10vp'), right: $r('app.float.10vp') })
            .flexGrow(1)

          Image($r('app.media.ic_arrow_right_blue'))
            .size({ width: $r('app.float.30vp'), height: $r('app.float.30vp') })
        }
        .width(Constants.FULL_PERCENT)
        .onClick(() => {
          if (Utils.isEmpty(this.userData.userInfo.username)) {
            this.jumpLogin()
          }
        })

        // 功能
        if (!Utils.isEmpty(this.userData.userInfo.username)) {
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            this.UserInfoItem('排名', this.userData.coinInfo.rank, () => this.jumpPath(Constants.RANK))
            this.UserInfoItem('收藏', `${this.userData.userInfo.collectIds.length}`, () => this.jumpPath(Constants.COLLECT))
            this.UserInfoItem('等级', `${this.userData.coinInfo.level}`, () => this.jumpPath(Constants.LEVEL))
            this.UserInfoItem('积分', `${this.userData.coinInfo.coinCount}`, () => this.jumpPath(Constants.COIN))
          }.margin({ top: $r('app.float.40vp') })
        } else {
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            this.UserInfoItem('排名', '——', () => this.jumpPath(Constants.RANK))
            this.UserInfoItem('收藏', '——', () => this.jumpPath(Constants.COLLECT))
            this.UserInfoItem('等级', '——', () => this.jumpPath(Constants.LEVEL))
            this.UserInfoItem('积分', '——', () => this.jumpPath(Constants.COIN))
          }.margin({ top: $r('app.float.40vp') })
        }
      }
    }.width(Constants.FULL_PERCENT)
    .padding({
      left:$r('app.float.10vp'),
      right:$r('app.float.10vp'),
      top:$r('app.float.30vp'),
      bottom:$r('app.float.20vp')
    })
  }
}