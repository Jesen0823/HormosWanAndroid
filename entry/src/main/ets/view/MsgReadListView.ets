import router from '@ohos.router'
import { MsgItem,MsgData } from '../bean/MsgBean'
import Constants from '../common/contants/Constants'
import msgViewModel from '../viewmodel/MsgViewModel'
import { NavigatorModel } from '../viewmodel/NavigatorModel'
import MsgItemView from './MsgItemView'
import * as Utils from '../utils/StringUtils'
import EventObservable from '../common/interface/EventObservable'

@Component
export default struct MsgReadListView{
  @State msgList: MsgItem[] = [];
  @State loginState:boolean = false;

  aboutToAppear() {
    let cookie = AppStorage.Get(Constants.Cookie);
    console.log('Jesen0823,MsgReadListView cookie:'+cookie);
    msgViewModel.getMsgRead(1).then((msgData: MsgData) => {
      this.msgList = msgData.datas
      console.log('Jesen0823,readMsg>>>', JSON.stringify(msgData));
    })
    this.loginState = !Utils.isEmpty(AppStorage.Get(Constants.Cookie) as string)
    EventObservable.observableLoginState.addObserver((state:boolean)=>{
      console.log('Jesen0823, MsgReadListView, observableLoginState: '+state);
      if (state) {
        if(this.loginState != state){
          this.loginState = state;
        }
      }
    });
  }

  @Builder
  MsgDataView() {
    Scroll() {
      Column() {
        ForEach(this.msgList, (item: MsgItem, index) => {
          Navigator({ target: Constants.WebPage_Path, type: NavigationType.Push }) {
            MsgItemView({ msgItem: item })
          }.params({ path: item.link, title: item.title } as NavigatorModel)
        })
      }
    }
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

  @Builder
  EmptyDataUI() {
    Text($r('app.string.empty_content_tip'))
      .textAlign(TextAlign.Center)
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
  }

  build() {
    if (this.loginState) {
      if (Utils.isEmpty(this.msgList)) {
        this.EmptyDataUI()
      } else {
        this.MsgDataView()
      }
    } else {
      this.MsgNoLonginUI()
    }
  }
}