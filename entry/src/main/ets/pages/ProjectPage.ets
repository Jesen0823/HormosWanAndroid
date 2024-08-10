import { ProjectItem } from '../bean/ProjectBean'
import Constants from '../common/contants/Constants';
import ProjectListView from '../view/ProjectListView';
import projectViewModel from '../viewmodel/ProjectViewModel';

@Component
export default struct ProjectPage {
  @State projectData: ProjectItem[] = [];
  @State currentIndex: number = 0;
  @State optionsMap: Map<number, number> = new Map();

  aboutToAppear() {
    projectViewModel.getProject().then((result: ProjectItem[]) => {
      console.log('Jesen0823,ProjectPage getProject>>>', JSON.stringify(result));
      this.projectData = result;
      this.projectData.forEach((project, index) => {
        this.optionsMap[index] = project.id;
      })
    })
  }

  @Builder
  BuildTabUI(index: number) {
    Column() {
      Text(this.projectData[index].name)
        .height(Constants.FULL_PERCENT)
        .fontSize(this.currentIndex === index ? $r('app.float.24fp') : $r('app.float.18fp'))
        .fontWeight(this.currentIndex === index ? Constants.TYPE_FONT_WEIGHT : Constants.DESC_FONT_WEIGHT)
        .fontColor($r('app.color.black'))
    }.padding({ left: $r('app.float.8vp'), right: $r('app.float.8vp') })
    .margin({
      left: index === 0 ? $r('app.float.8vp') : 0,
      right: index === this.projectData.length - 1 ? $r('app.float.8vp') : 0
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.Start }) {
      ForEach(this.projectData, (projectItem: ProjectItem, index: number) => {
        TabContent() {
          ProjectListView({ index, optionsMap: this.optionsMap, currentIndex: $currentIndex })
        }.tabBar(this.BuildTabUI(index??0))
      }, (tabItem: ProjectItem) => JSON.stringify(tabItem))
    }
    .barHeight($r('app.float.50vp'))
    .height(Constants.FULL_PERCENT)
    .barMode(BarMode.Scrollable)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
    .vertical(false)
  }
}