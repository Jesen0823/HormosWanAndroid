/**
 * 导航-数据类
 */
import { Article } from './ArticleBean';

//体系数据
export class NavData {
  data: NavItem[] = [];
}

export class NavItem {
  articleList: [] = [];
  author: string = '';
  children: NavItem[] = [];
  courseId: number = 0;
  cover: string = '';
  desc: string = '';
  id: number = 0;
  lisense: string = '';
  lisenseLink: string = '';
  name: string = '';
  order: number = 0;
  parentChapterId: number = 0;
  type: number = 0;
  userControlSetTop: boolean = false;
  visible: number = 0;
}
//知识体系下的文章
export class NavArticle {
  curPage: number = 1;
  offset: number = 0;
  over: boolean = false;
  pageCount: number = 0;
  size: number = 0;
  total: number = 0;
  datas: Article[] = [];
}