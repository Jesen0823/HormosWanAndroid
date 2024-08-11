import Constants from '../common/contants/Constants';
import { BottomTabsDatas } from '../viewmodel/BottomTabsModel';
import HomePage from './HomePage';
import MinePage from './MinePage';
import MsgPage from './MsgPage';
import NavPage from './NavPage';
import ProjectPage from './ProjectPage';

@Entry
@Component
struct MainPage {
  @State bottomIndex: number = 0;
  private tabsController: TabsController = new TabsController();

  @Builder TabBuilder(index: number, _name: string) {
    Column() {
      Image(this.bottomIndex == index ? BottomTabsDatas[index].iconSelected : BottomTabsDatas[index].icon)
        .width(Constants.ICON_SIZE)
        .height(Constants.ICON_SIZE)
        .objectFit(ImageFit.Contain)

      Text(BottomTabsDatas[index].text)
        .fontSize($r('app.float.bottom_font_size'))
        .opacity(Constants.OPACITY)
        .fontColor(this.bottomIndex === index ? $r('app.color.bottom_tabs_font_color_selected')
                                              : $r('app.color.bottom_tabs_font_color'))
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .border({ width: { top: Constants.BORDER_WIDTH }, color: $r('app.color.color_border') })
    .backgroundColor($r('app.color.bottom_tabs_background_color'))
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.End, justifyContent: FlexAlign.End }) {
      Tabs({ barPosition: BarPosition.End, index: 0, controller: this.tabsController }) {
        TabContent() {
          HomePage()
        }.tabBar(this.TabBuilder(0, 'Home'))

        TabContent() {
          NavPage()
        }.tabBar(this.TabBuilder(1, 'Nav'))

        TabContent() {
          ProjectPage()
        }.tabBar(this.TabBuilder(2, 'Project'))

        TabContent() {
          MsgPage()
        }.tabBar(this.TabBuilder(3, 'Msg'))

        TabContent() {
          MinePage()
        }.tabBar(this.TabBuilder(4, 'Mine'))
      }
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
      .vertical(false)
      .scrollable(false)
      .barHeight(Constants.BAR_HEIGHT)
      .onChange((index: number) => this.bottomIndex = index)
      .animationDuration(0)
    }
    .width(Constants.FULL_PERCENT)
  }

  onIndexChange() {
    this.tabsController.changeIndex(this.bottomIndex);
  }

  pageTransition() {
    PageTransitionEnter({ duration: Constants.SHARED_DURATION })
      .slide(SlideEffect.Top)
    PageTransitionExit({ delay: Constants.EXIT_DELAY })
      .opacity(0)
  }
}