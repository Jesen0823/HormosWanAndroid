import { Article, ArticleList } from '../bean/ArticleBean';
import Constants from '../common/contants/Constants';
import { NavigatorModel } from '../viewmodel/NavigatorModel';
import navViewModel from '../viewmodel/NavViewModel';
import ArticleItemView from './ArticleItemView';
import * as Utils from '../utils/StringUtils';
import { PullToRefresh } from '@ohos/pulltorefresh'
import prompt from '@ohos.promptAction';

@Component
export default struct NavListView {
  index: number = 0;
  optionsMap: Map<number, number> = new Map;
  @Watch('tabChanged') @Link currentIndex: number;
  @State articleListData: ArticleList = new ArticleList();
  @State articleDatas: Article[] = [];
  @State pageNum: number = 1;

  // 用来绑定列表组件
  private scroller: Scroller = new Scroller();

  aboutToAppear() {
    this.tabChanged();
  }

  tabChanged() {
    this.getNavListData(this.pageNum);
  }

  getNavListData(page: number) {
    navViewModel.getNavArticleList(page, this.optionsMap[this.currentIndex]).then((data: ArticleList) => {
      console.log('Jesen0823,NavListView getNavListData >>>data', data)
      this.articleListData = data;
      this.articleDatas.push(...data.datas);
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
    if (Utils.isEmpty(this.articleDatas)) {
      this.EmptyDataUI()
    } else {
      PullToRefresh({
        data: $articleDatas,
        scroller: this.scroller,
        customList: () => this.ListUI(),
        onRefresh: () => {
          return new Promise<string>((resolve, reject) => {
            setTimeout(() => {
              resolve('刷新成功');
              this.pageNum = 0;
              this.getNavListData(this.pageNum)
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
                this.getNavListData(++this.pageNum);
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