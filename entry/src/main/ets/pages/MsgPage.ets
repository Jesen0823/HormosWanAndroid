import MsgReadListView from '../view/MsgReadListView';
import MsgUnReadListView from '../view/MsgUnReadListView';

@Component
export default struct MsgPage {
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0;

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        MsgUnReadListView()
      }.tabBar({ icon: $r('app.media.ic_unread_mk'), text: $r('app.string.un_read_msg_mk') })

      TabContent() {
        MsgReadListView()
      }.tabBar({ icon: $r('app.media.ic_read_mk'), text: $r('app.string.has_read_msg_mk') })
    }.onChange((index)=>{
      this.currentIndex = index;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }
}