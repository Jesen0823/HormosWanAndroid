import { Article, ArticleList } from '../bean/ArticleBean'
import { Banner } from '../bean/BannerBean'
import HttpConfig from '../net/HttpConfig'
import { articleListReq, articleTopReq, bannerReq } from '../net/HttpRequest'
import ResponseResult from '../net/ResponseResult'
import Logger from '../utils/Logger'

class HomeViewModel {

  getHomeData() {
    return Promise.all([
      this.getBanner(),
      this.getArticleTop(),
      this.getArticle(0)
    ])
  }

  getBanner(): Promise<Banner[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      bannerReq().then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getBanner failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }

  getArticleTop(): Promise<Article[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      articleTopReq().then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getArticleTop failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }

  getArticle(page: number): Promise<ArticleList> {
    return new Promise(async (resolve: Function, reject: Function) => {
      articleListReq(page).then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getArticle failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }
}

let homeViewModel = new HomeViewModel();

export default homeViewModel as HomeViewModel;