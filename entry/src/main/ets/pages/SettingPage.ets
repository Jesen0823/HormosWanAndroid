import ResourceBean from '../bean/ResourceBean'
import Constants from '../common/contants/Constants'
import TitleBar from '../view/TitleBar'
import settingViewModel from '../viewmodel/SettingViewModel'

@Preview
@Entry
@Component
export default struct SettingPage {
  @Builder
  settingCell(item: ResourceBean) {
    Row() {
      Row({ space: 12 }) {
        Image(item.img)
          .width($r('app.float.22vp'))
          .height($r('app.float.22vp'))
        Text(item.title)
          .fontSize($r('app.float.16fp'))
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(Constants.FULL_PERCENT)
    .padding({
      left: $r('app.float.8vp'),
      right: $r('app.float.22vp')
    })
  }

  build() {
    Column() {
      TitleBar({ title: '设置' })

      List() {
        ForEach(settingViewModel.getSettingListData(), (item: ResourceBean) => {
          ListItem() {
            this.settingCell(item)
          }
          .height($r('app.float.48vp'))
        }, (item: ResourceBean) => JSON.stringify(item))
      }
      .backgroundColor(Color.White)
      .width(Constants.FULL_PARENT)
      .height(Constants.SET_LIST_WIDTH)
      .divider({
        strokeWidth: $r('app.float.1vp'),
        color: Color.Grey,
        startMargin: $r('app.float.42vp'),
        endMargin: $r('app.float.24vp')
      })
      .borderRadius($r('app.float.16vp'))
      .padding({ top: $r('app.float.4vp'), bottom: $r('app.float.4vp') })

      Button('退出登录', { type: ButtonType.Capsule })
        .width(Constants.BUTTON_WIDTH)
        .height($r('app.float.40vp'))
        .fontSize($r('app.float.16fp'))
        .fontColor($r('app.color.fire_brick'))
        .fontWeight(FontWeight.Medium)
        .backgroundColor($r('app.color.gainsboro'))
        .margin({ bottom: $r('app.float.50vp') })
        .onClick(() => {
          settingViewModel.logout()
        })

      Blank()

    }
    .height(Constants.FULL_PARENT)
  }
}