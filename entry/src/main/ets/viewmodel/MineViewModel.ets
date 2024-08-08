import { UserData } from '../bean/UserInfoBean'
import HttpConfig from '../net/HttpConfig';
import { userReq } from '../net/HttpRequest';
import ResponseResult from '../net/ResponseResult';
import Logger from '../utils/Logger';

class MineViewModel {
  getUserInfo(): Promise<UserData> {
    return new Promise(async (resolve: Function, reject: Function) => {
      userReq().then((data: ResponseResult) => {
        if (data.errorCode == HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getUserInfo failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }
}

let mineViewModel = new MineViewModel();

export default mineViewModel as MineViewModel;