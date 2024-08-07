import { Article, ArticleList } from '../bean/ArticleBean';
import { Banner } from '../bean/BannerBean';
import Constants from '../common/contants/Constants';
import ArticleItemView from '../view/ArticleItemView';
import homeViewModel from '../viewmodel/HomeViewModel';
import { NavigatorModel } from '../viewmodel/NavigatorModel';
import { PullToRefresh } from '@ohos/pulltorefresh'
import prompt from '@ohos.promptAction';

@Component
export default struct HomePage {
  private swiperController: SwiperController = new SwiperController();
  private scroller: Scroller = new Scroller(); // 需绑定列表组件

  @State bannerData: Banner[] = [];
  @State articleTopData: Article[] = [];
  @State articleListData: ArticleList = new ArticleList()
  @State articleData: Article[] = [];
  @State pageNum: number = 0;

  async aboutToAppear() {
    this.getHomeBannerData();
    this.getHomeArticleListData(0);
  }

  getHomeBannerData() {
    homeViewModel.getHomeData().then(result => {
      this.bannerData = result[0] as Banner[]
      this.articleTopData = (result[1] as Article[])
      this.articleTopData.forEach(item => {
        item.isTop = true
      })
      this.articleListData = result[2]

      this.articleData = [...this.articleTopData, ...this.articleListData.datas]
      console.log("result")
    })
  }

  getHomeArticleListData(page: number) {
    homeViewModel.getArticle(page).then(result => {
      this.articleData.push(...result.datas)
      console.log('getHomeArticleListData article>>>', JSON.stringify(result))
    })
  }

  @Builder
  private homeListView() {
    List({ scroller: this.scroller }) {
      // 轮播图
      ListItem() {
        if (this.bannerData.length > 0) {
          Swiper(this.swiperController) {
            ForEach(this.bannerData, (banner: Banner) => {
              Navigator({ target: Constants.WebPage_Path, type: NavigationType.Push }) {
                Image(banner.imagePath)
              }.params({ path: banner.url, title: banner.title } as NavigatorModel)
            }, (img: Resource) => JSON.stringify(img.id)
            )
          }
          .height(200)
          .width(Constants.FULL_PERCENT)
          .autoPlay(true)
        }
      }

      //文章条目
      ForEach(this.articleData, (article: Article) => {
        ListItem() {
          Navigator({ target: Constants.WebPage_Path, type: NavigationType.Push }) {
            ArticleItemView({ article: article })
          }.params({ path: article.link, title: article.title } as NavigatorModel)
        }
      })
    }
    .edgeEffect(EdgeEffect.None) // 滑动到边缘无效果
  }

  build() {
    Column() {
      PullToRefresh({
        data: $articleData,
        scroller: this.scroller,
        customList: () => this.homeListView(),
        onRefresh: () => {
          return new Promise<string>((resolve, reject) => {
            setTimeout(() => {
              resolve('刷新成功');
              this.pageNum = 0;
              this.articleData.forEach((item, index) => {
                this.articleData.pop();
              })
              this.getHomeArticleListData(this.pageNum)
            }, 1000);
          });
        },

        onLoadMore: () => {
          return new Promise<string>((resolve, reject) => {
            setTimeout(() => {
              resolve('加载更多');
              if (!this.articleListData.over) {
                this.getHomeArticleListData(++this.pageNum);
              } else {
                prompt.showToast({ message: $r('app.string.no_more_data') });
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