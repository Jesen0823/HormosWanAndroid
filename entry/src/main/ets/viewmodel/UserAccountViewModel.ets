import HttpConfig from '../net/HttpConfig';
import {loginReq,registerReq} from '../net/HttpRequest';
import ResponseResult from '../net/ResponseResult';
import {UserInfo} from '../bean/UserInfoBean';
import Logger from '../utils/Logger';

class UserAccountViewModel{

  userLogin(userName:string,passWord:string):Promise<ResponseResult>{
    return new Promise(async (resolve:Function,reject:Function) =>{
      loginReq(userName,passWord).then((data:ResponseResult)=>{
        if(data.errorCode === HttpConfig.SERVER_CODE_SUCCESS){
          resolve(data);
        }else {
          Logger.error('userLogin failed',JSON.stringify(data));
          reject(data);
        }
      })
    })
  }

  userRegister(userName: string, passWord: string, rePassWord: string): Promise<ResponseResult> {
    return new Promise(async (resolve: Function, reject: Function) => {
      registerReq(userName, passWord, rePassWord).then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data);
        } else {
          Logger.error('userRegister failed', JSON.stringify(data));
          reject(data);
        }
      })
    })
  }
}

let userAccountViewModel = new UserAccountViewModel();
export default userAccountViewModel as UserAccountViewModel;