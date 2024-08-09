import router from '@ohos.router';
import { MsgData, MsgItem } from '../bean/MsgBean'
import Constants from '../common/contants/Constants';
import msgViewModel from '../viewmodel/MsgViewModel';
import * as Utils from '../utils/StringUtils';
import MsgItemView from './MsgItemView';

@Component
export default struct MsgUnReadListView {
  @State msgList: MsgItem[] = [];

  aboutToAppear() {
    msgViewModel.getMsgUnRead().then((data: MsgData) => {
      this.msgList = data.datas;
      console.log('MsgUnReadListView getMsgUnRead>>>', data);
    })
  }

  @Builder
  EmptyDataUI() {
    Text($r('app.string.empty_content_tip'))
      .textAlign(TextAlign.Center)
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
  }

  @Builder
  MsgNoLonginUI() {
    Text($r('app.string.msg_need_login'))
      .textAlign(TextAlign.Center)
      .backgroundColor($r('app.color.deep_sky_blue'))
      .padding({
        top: $r('app.float.10vp'),
        bottom: $r('app.float.10vp'),
        left: $r('app.float.20vp'),
        right: $r('app.float.20vp')
      })
      .borderRadius($r('app.float.5vp'))
      .onClick(() => {
        router.pushUrl({
          url: Constants.LoginRegister_Path
        })
      })
  }

  build() {
    if (Utils.isEmpty(AppStorage.Get(Constants.Cookie) as string)) {
      if (Utils.isEmpty(this.msgList)) {
        this.EmptyDataUI()
      } else {
        Scroll() {
          Column() {
            ForEach(this.msgList, (item: MsgItem, index) => {
              MsgItemView({ msgItem: item })
            })
          }
        }
      }
    } else {
      this.MsgNoLonginUI()
    }
  }
}