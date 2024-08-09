import * as Utils from "../utils/StringUtils";
import { PullToRefresh } from '@ohos/pulltorefresh'
import prompt from '@ohos.promptAction';
import { NavigatorModel } from '../viewmodel/NavigatorModel';
import { ArticleList, Article } from '../bean/ArticleBean';
import projectViewModel from '../viewmodel/ProjectViewModel';
import Constants from '../common/contants/Constants';
import ArticleItemView from './ArticleItemView';

@Component
export default struct ProjectListView {
  index: number = 0;
  optionsMap: Map<number, number> = new Map;
  @Watch('tabChanged') @Link currentIndex: number;
  @State articleListData: ArticleList = new ArticleList();
  @State articleDatas: Article[] = [];
  @State pageNum: number = 1;

  // 用来绑定列表组件
  private scroller: Scroller = new Scroller();

  tabChanged() {
    if (this.currentIndex !== this.index) {
      return;
    }
    this.getProjectListData(this.pageNum);
  }

  aboutToAppear() {
    this.tabChanged();
  }

  getProjectListData(page: number) {
    projectViewModel.getProjectList(page, this.optionsMap[this.currentIndex])
      .then((data: ArticleList) => {
        console.log('ProjectListView getProjectList>>>', data)
        this.articleListData = data
        this.articleDatas.push(...data.datas)
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
  ListUI() {
    List({ scroller: this.scroller, space: 8 }) {
      ForEach(this.articleDatas, (at: Article) => {
        ListItem() {
          Navigator({ target: Constants.WebPage_Path, type: NavigationType.Push }) {
            ArticleItemView({ article: at })
          }.params({ path: at.link, title: at.title } as NavigatorModel)
        }
      })
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .edgeEffect(EdgeEffect.None)
  }

  build() {
    if (Utils.isEmpty(this.articleListData.datas)) {
      this.EmptyDataUI()
    } else {
      Column() {
        PullToRefresh({
          data: $articleDatas,
          scroller: this.scroller,
          customList: () => this.ListUI(),
          onRefresh: () => {
            return new Promise<string>((resolve, reject) => {
              setTimeout(() => {
                resolve('刷新成功');
                this.pageNum = 1;
                this.getProjectListData(this.pageNum);
              }, 1000);
            });
          },
          onLoadMore: () => {
            return new Promise<string>((resolve, reject) => {
              setTimeout(() => {
                resolve('加载更多');
                if (this.articleListData.over) {
                  prompt.showToast({ message: $r('app.string.no_more_data') });
                } else {
                  this.getProjectListData(++this.pageNum);
                }
              }, 1000);
            });
          },
          customLoad: null,
          customRefresh: null,
        })
      }
    }
  }
}