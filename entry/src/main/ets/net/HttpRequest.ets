import Api from './Api';
import { httpRequestGet, httpRequestPost } from './HttpService';
import ResponseResult from './ResponseResult';

//01- login(登录)
const loginReq = (username: string, password: string): Promise<ResponseResult> =>
httpRequestPost(
  `${Api.loginUrl}?username=${username}&password=${password}`,
  Object({
    'username': username,
    "password": password
  })
);

// 02- register(注册)
const registerReq = (username: string, password: string, repassword: string): Promise<ResponseResult> =>
httpRequestPost(
  `${Api.registerUrl}?username=${username}&password=${password}&repassword=${repassword}`,
  Object({
    'username': username,
    'password': password,
    'repassword': repassword
  })
);

// 03- 登出
const logoutReq = (): Promise<ResponseResult> => httpRequestGet(Api.logoutUrl);

export {
  loginReq, registerReq, logoutReq, }