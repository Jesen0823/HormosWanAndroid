import router from '@ohos.router';
import { MsgData, MsgItem } from '../bean/MsgBean'
import Constants from '../common/contants/Constants';
import msgViewModel from '../viewmodel/MsgViewModel';
import * as Utils from '../utils/StringUtils';
import MsgItemView from './MsgItemView';
import EventObservable from '../common/interface/EventObservable';

@Component
export default struct MsgUnReadListView {
  @State msgList: MsgItem[] = [];
  @State loginState:boolean = false;

  aboutToAppear() {
    let cookie = AppStorage.Get(Constants.Cookie);
    console.log('Jesen0823,MsgUnReadListView cookie:'+cookie);
    msgViewModel.getMsgUnRead().then((data: MsgData) => {
      this.msgList = data.datas;
      console.log('Jesen0823,MsgUnReadListView getMsgUnRead>>>', data);
    })
    this.loginState = !Utils.isEmpty(AppStorage.Get(Constants.Cookie) as string)
    EventObservable.observableLoginState.addObserver((state:boolean)=>{
      console.log('Jesen0823, MsgUnReadListView, observableLoginState: '+state);
      if (state) {
        if(this.loginState != state){
          this.loginState = state;
        }
      }
    });
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
    if (this.loginState) {
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