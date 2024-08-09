/**
 * 消息
 */

export class MsgData {
  curPage: number = 0;
  datas: MsgItem[] = [];
  offset: number = 0;
  over: boolean = false;
  pageCount: number = 0;
  size: number = 0;
  total: number = 0;
}

export class MsgItem {
  category: number = 0;
  date: number = 0;
  fromUser: string = '疯疯癫癫'; //作者
  fromUserId: number = 0;
  fullLink: string = ''; //链接
  id: number = 0;
  isRead: number = 0;
  link: string = '';
  message: string = '随着Gradle和Android Gradle Plugin的版本升级，以及Kotlin DSL的加入，Gradle的配置和使用方式发生了很大的变化'; //消息内容
  niceDate: string = '2020-03-08'; //日期
  tag: string = '均衡化'; //标签
  title: string = 'Gradle8.0插件的使用方式'; //标题
  userId: number = 0;
}