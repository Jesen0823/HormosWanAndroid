import router from '@ohos.router';
import ResourceBean from '../bean/ResourceBean';
import Constants from '../common/contants/Constants'
import { logoutRequest } from '../net/HttpRequest'

class SettingViewModel {
  logout() {
    logoutRequest().then(result => {
      if (AppStorage.Has(Constants.Cookie)) {
        AppStorage.Set(Constants.Cookie, '');
        PersistentStorage.DeleteProp(Constants.Cookie);
        router.replaceUrl({ url: Constants.MainPage_Path });
      }
    })
  }

  getSettingListData(): Array<ResourceBean> {
    let settingListData: ResourceBean[] = [
      new ResourceBean($r('app.string.setting_list_theme'), $r('app.media.ic_theme')),
      new ResourceBean($r('app.string.setting_list_language'), $r('app.media.ic_launguage')),
      new ResourceBean($r('app.string.setting_list_about'), $r('app.media.ic_about')),
    ];
    return settingListData;
  }
}

let settingViewModel = new SettingViewModel();
export default settingViewModel as SettingViewModel;