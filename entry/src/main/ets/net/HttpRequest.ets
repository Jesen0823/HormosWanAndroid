import Api from './Api';
import { httpRequestGet, httpRequestPost } from './HttpService';
import ResponseResult from './ResponseResult';

//01- login 登录
const loginRequest = (username: string, password: string): Promise<ResponseResult> =>
httpRequestPost(
  `${Api.loginUrl}?username=${username}&password=${password}`,
  Object({
    'username': username,
    "password": password
  })
);

// 02- register 注册
const registerRequest = (username: string, password: string, repassword: string): Promise<ResponseResult> =>
httpRequestPost(
  `${Api.registerUrl}?username=${username}&password=${password}&repassword=${repassword}`,
  Object({
    'username': username,
    'password': password,
    'repassword': repassword
  })
);

// 03- logout 登出
const logoutRequest = (): Promise<ResponseResult> => httpRequestGet(Api.logoutUrl);

//04- home 首页
const bannerRequest = ():Promise<ResponseResult> => httpRequestGet(Api.bannerUrl);
const articleTopRequest = ():Promise<ResponseResult> => httpRequestGet(Api.articleTopUrl);
const articleListRequest = (page: number):Promise<ResponseResult> => httpRequestGet(`${Api.articleListUrl}/${page}/json`);

//05- Mine 我的
const userRequest = ():Promise<ResponseResult> => httpRequestGet(Api.userInfUrl);

//06- 积分 排行榜
const rankRequest = (page:number):Promise<ResponseResult> => httpRequestGet(`${Api.rankUrl}/${page}/json`);
const coinRequest = (page:number):Promise<ResponseResult> => httpRequestGet(`${Api.coinUrl}/${page}/json`);

//07- nav 导航
const navRequest = ():Promise<ResponseResult> => httpRequestGet(Api.navUrl);
const navListRequest = (page: number, cid: number):Promise<ResponseResult> => httpRequestGet(`${Api.navListUrl}/${page}/json?cid=${cid}`);

//08- Project 项目
const projectReq = ():Promise<ResponseResult> => httpRequestGet(Api.projectUrl);
const projectListReq = (page: number, cid: number):Promise<ResponseResult> => httpRequestGet(`${Api.projectListUrl}/${page}/json?cid=${cid}`);


export {
  loginRequest, registerRequest, logoutRequest,
  bannerRequest,articleTopRequest,articleListRequest,
  userRequest as userReq,
  rankRequest,coinRequest,
  navRequest,navListRequest,
  projectReq,projectListReq,
}