import { ArticleList } from '../bean/ArticleBean';
import { ProjectItem } from '../bean/ProjectBean';
import HttpConfig from '../net/HttpConfig';
import { projectListReq, projectReq } from '../net/HttpRequest';
import ResponseResult from '../net/ResponseResult';
import Logger from '../utils/Logger';

class ProjectViewModel {
  getProject(): Promise<ProjectItem[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      projectReq().then((result: ResponseResult) => {
        if (result.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(result.data);
        } else {
          Logger.error('getProject failed', JSON.stringify(result));
          reject($r('app.string.page_none_msg'));
        }
      });
    })
  }

  getProjectList(page: number, cid: number): Promise<ArticleList> {
    return new Promise(async (resolve: Function, reject: Function) => {
      projectListReq(page = page, cid = cid).then((result: ResponseResult) => {
        if (result.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
          resolve(result.data);
        } else {
          Logger.error('getProjectList failed', JSON.stringify(result));
          reject($r('app.string.page_none_msg'));
        }
      })
    })
  }
}

let projectViewModel = new ProjectViewModel();

export default projectViewModel as ProjectViewModel;