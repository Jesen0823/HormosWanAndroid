export default class Api{
  /**
   * The host address of the server.
   */
  static readonly baseURL: string = 'https://www.wanandroid.com/';

  //1-登录、注册、退出
  static readonly loginUrl: string = Api.baseURL + 'user/login';
  static readonly registerUrl: string = Api.baseURL + 'user/register';
  static readonly logoutUrl: string = Api.baseURL + 'user/logout/json';

  //2-用户信息
  static readonly userInfUrl: string = Api.baseURL + 'user/lg/userinfo/json';
}


/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json',
  FORM = 'multipart/form-data',
  FORM_URLENCODED = 'application/x-www-form-urlencoded'
}
