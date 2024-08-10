import { NavItem } from '../bean/NavBean'
import Constants from '../common/contants/Constants';
import navViewModel from '../viewmodel/NavViewModel';

@Component
export default struct NavPage {
  @State navData: NavItem[] = [];

  aboutToAppear() {
    navViewModel.getNavPageData().then(result => {
      console.log('Jesen0823,NavPage >>getNavPageData ', JSON.stringify(result));
      this.navData = result;
    })

    navViewModel.getNavArticleList(0, 60).then(result => {
      console.log('Jesen0823,NavPage >> getNavArticleList', JSON.stringify(result));
    })
  }

  @Builder
  itemHeadUI(text: string) {
    Text(text)
      .fontSize($r('app.float.20fp'))
      .fontWeight(FontWeight.Bold)
      .backgroundColor($r('app.color.light_gray'))
      .width(Constants.FULL_PERCENT)
      .padding($r('app.float.6vp'))
  }

  build() {
    List() {
      ForEach(this.navData, (navItem: NavItem) => {
        ListItemGroup({ header: this.itemHeadUI(navItem.name) }) {
          ListItem() {
            Flex({ wrap: FlexWrap.Wrap, alignContent: FlexAlign.SpaceEvenly }) {
              ForEach(navItem.children, (item: NavItem, index) => {
                Navigator({ target: Constants.NavTabPage_Path, type: NavigationType.Push }) {
                  Text(item.name)
                    .textAlign(TextAlign.Center)
                    .height($r('app.float.30vp'))
                    .border({ width: $r('app.float.1vp') })
                    .borderColor(Color.Black)
                    .borderRadius($r('app.float.4vp'))
                    .padding({
                      top: $r('app.float.4vp'),
                      bottom: $r('app.float.4vp'),
                      left: $r('app.float.6vp'),
                      right: $r('app.float.6vp')
                    })
                    .margin($r('app.float.5vp'))
                }.params({ index: index, data: navItem })
              })
            }.width('90%').padding($r('app.float.10vp'))
          }
        }
      })
    }.height(Constants.FULL_PERCENT)
    .width(Constants.FULL_PERCENT)
  }
}