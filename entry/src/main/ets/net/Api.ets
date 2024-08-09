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

  //3-首页
  static readonly bannerUrl: string = Api.baseURL + 'banner/json';
  static readonly articleTopUrl: string = Api.baseURL + 'article/top/json';
  static readonly articleListUrl: string = Api.baseURL + 'article/list';

  //4-排行榜、积分
  static readonly rankUrl: string = Api.baseURL + 'coin/rank/';
  static readonly coinUrl: string = Api.baseURL + 'lg/coin/list/';

  //5-导航
  static readonly navUrl: string = Api.baseURL + 'tree/json';
  static readonly navListUrl: string = Api.baseURL + 'article/list';

  //6-项目
  static readonly projectUrl: string = Api.baseURL + 'project/tree/json';
  static readonly projectListUrl: string = Api.baseURL + 'project/list';

  //7-消息 未读/已读
  static readonly msgUnreadUrl: string = Api.baseURL + 'message/lg/count_unread/json';
  static readonly msgReadUrl: string = Api.baseURL + 'message/lg/readed_list/';
}


/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json',
  FORM = 'multipart/form-data',
  FORM_URLENCODED = 'application/x-www-form-urlencoded'
}
