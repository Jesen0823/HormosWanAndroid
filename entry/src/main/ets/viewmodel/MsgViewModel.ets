import { MsgData } from '../bean/MsgBean';
import HttpConfig from '../net/HttpConfig';
import {msgUnReadRequest,msgReadRequest} from '../net/HttpRequest';
import ResponseResult from '../net/ResponseResult';
import Logger from '../utils/Logger';

class MsgViewModel{

  getMsgUnRead():Promise<MsgData>{
    return new Promise(async (resolve:Function,reject:Function)=>{
      msgUnReadRequest().then((result:ResponseResult)=>{
        if(result.errorCode == HttpConfig.SERVER_CODE_SUCCESS){
          resolve(result.data);
        }else{
          console.log('Jesen0823,getMsgUnRead failed',JSON.stringify(result));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }

  getMsgRead(page:number): Promise<MsgData> {
    return new Promise(async (resolve: Function, reject: Function) => {
      msgReadRequest(page).then((data: ResponseResult) => {
        if (data.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getMsgUnRead failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }
}

let msgViewModel = new MsgViewModel();
export default msgViewModel as MsgViewModel;