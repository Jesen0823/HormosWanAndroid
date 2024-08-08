import { NavArticle, NavItem } from '../bean/NavBean'
import HttpConfig from '../net/HttpConfig'
import { navListRequest, navRequest } from '../net/HttpRequest'
import ResponseResult from '../net/ResponseResult'
import Logger from '../utils/Logger'

class NavViewModel{

  getNavPageData():Promise<NavItem[]>{
    return new Promise(async (resolve:Function,reject:Function)=>{
      navRequest().then((data:ResponseResult)=>{
        if(data.errorCode === HttpConfig.SERVER_CODE_SUCCESS){
          resolve(data.data);
        }else {
          Logger.error('getNavPageData failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }

  // 获取文章列表
  getNavArticleList(page:number,cid:number):Promise<NavArticle>{
    return new Promise(async (resolve:Function,reject:Function)=>{
      navListRequest(page=page,cid=cid).then((data:ResponseResult)=>{
        if(data.errorCode == HttpConfig.SERVER_CODE_SUCCESS){
          resolve(data.data);
        }else{
          Logger.error('getNavArticleList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }
}

let navViewModel = new NavViewModel;
export default navViewModel as NavViewModel;
