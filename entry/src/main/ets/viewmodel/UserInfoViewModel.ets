import { coinRequest, rankRequest } from '../net/HttpRequest';
import { RankData } from '../bean/RankBean';
import ResponseResult from '../net/ResponseResult';
import HttpConfig from '../net/HttpConfig';
import Logger from '../utils/Logger';
import { CoinData } from '../bean/CoinBean';
class UserInfoViewModel{

  // 排行榜
  getRank(page:number):Promise<RankData>{
    return new Promise(async (resolve:Function,reject:Function)=>{
      rankRequest(page).then((data:ResponseResult)=>{
        if(data.errorCode === HttpConfig.SERVER_CODE_SUCCESS){
          resolve(data.data);
        }else{
          Logger.error('getRank failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }

  // 签到积分
  getCoin(page: number): Promise<CoinData> {
    return new Promise(async (resolve: Function, reject: Function) => {
      coinRequest(page).then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getRank failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }
}

let userInfoViewModel = new UserInfoViewModel();
export default userInfoViewModel as UserInfoViewModel;