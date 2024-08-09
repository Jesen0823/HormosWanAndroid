import router from '@ohos.router'
import { ProjectItem } from '../bean/ProjectBean';
import Constants from '../common/contants/Constants';
import NavListView from '../view/NavListView';
import TitleBar from '../view/TitleBar';

@Entry
@Component
export default struct NavDetailPage {
  private tabsController: TabsController = new TabsController();
  @State routerParams: object = router.getParams();
  @State projectData: ProjectItem[] = [];
  @State currentIndex: number = 0;
  @State optionsMap: Map<number, number> = new Map(); //记录tab_index对应的cid

  aboutToAppear() {
    this.currentIndex = this.routerParams['index']??0;
    this.projectData = (this.routerParams['data'] as ProjectItem).children;
    this.projectData.forEach((pro,index)=>{
      this.optionsMap[index] = pro.id;
    });
  }

  @Builder
  buildTabUI(index: number) {
    Column() {
      Text(this.projectData[index].name)
        .height(Constants.FULL_PERCENT)
        .fontSize(this.currentIndex === index ? $r('app.float.24fp') : $r('app.float.18fp'))
        .fontWeight(this.currentIndex === index ? Constants.TYPE_FONT_WEIGHT : Constants.DESC_FONT_WEIGHT)
        .fontColor($r('app.color.black'))
    }
    .padding({ left: $r('app.float.8vp'), right: $r('app.float.8vp') })
    .margin({
      left: index === 0 ? $r('app.float.8vp') : 0,
      right: index === this.projectData.length - 1 ? $r('app.float.8vp') : 0
    })
  }

  build() {
    Column(){
      TitleBar({title:(this.routerParams['data'] as ProjectItem).name})
      Tabs({barPosition:BarPosition.Start}){
        ForEach(this.projectData,(proItem,index)=>{
          TabContent(){
            NavListView({index:index,optionsMap:this.optionsMap,currentIndex:$currentIndex})
          }.tabBar(this.buildTabUI(index))
        },(tabItem:ProjectItem)=>JSON.stringify(tabItem))
      }
      .barHeight($r('app.float.50vp'))
      .height(Constants.FULL_PERCENT)
      .barMode(BarMode.Scrollable)
      .onChange((index:number)=>{
        this.currentIndex = index;
        this.tabsController.changeIndex(this.currentIndex);
      }).vertical(false)
    }
  }
}