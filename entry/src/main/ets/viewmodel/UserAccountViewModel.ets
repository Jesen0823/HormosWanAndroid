import HttpConfig from '../net/HttpConfig';
import {loginRequest,registerRequest} from '../net/HttpRequest';
import ResponseResult from '../net/ResponseResult';
import {UserInfo} from '../bean/UserInfoBean';
import Logger from '../utils/Logger';
import EventObservable from '../common/interface/EventObservable';

class UserAccountViewModel{

  userLogin(userName:string,passWord:string):Promise<ResponseResult>{
    return new Promise(async (resolve:Function,reject:Function) =>{
      loginRequest(userName,passWord).then((data:ResponseResult)=>{
        if(data.errorCode === HttpConfig.SERVER_CODE_SUCCESS){
          Logger.info('userLogin success');
          resolve(data);
          EventObservable.observableLoginState.setData(true);
        }else {
          Logger.error('userLogin failed',JSON.stringify(data));
          reject(data);
          EventObservable.observableLoginState.setData(false);
        }
      })
    })
  }

  userRegister(userName: string, passWord: string, rePassWord: string): Promise<ResponseResult> {
    return new Promise(async (resolve: Function, reject: Function) => {
      registerRequest(userName, passWord, rePassWord).then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          Logger.info('userRegister success');
          resolve(data);
          EventObservable.observableLoginState.setData(true);
        } else {
          Logger.error('userRegister failed', JSON.stringify(data));
          reject(data);
          EventObservable.observableLoginState.setData(false);
        }
      })
    })
  }
}

let userAccountViewModel = new UserAccountViewModel();
export default userAccountViewModel as UserAccountViewModel;