import router from '@ohos.router'
import Constants from '../common/contants/Constants'

/**
 * 标题栏
 */
@Preview
@Component
export default struct TitleBar {
  title: string|Resource = '' //中间标题

  build() {

    //1-头部
    Flex({ alignItems: ItemAlign.Center }) {
      Image($r('app.media.ic_arrow_left_blob'))
        .size({ width: $r('app.float.30vp'), height: $r('app.float.30vp') })
        .margin({ right: $r('app.float.10vp') ,left:$r('app.float.16vp')})
        .onClick(() => {
          router.back()
        })
      Text(this.title)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .maxLines(1)
        .fontWeight(FontWeight.Bold)
        .fontSize($r('app.float.24fp'))
        .flexGrow(1)

      Text('')
        .width($r('app.float.30vp'))
        .height($r('app.float.30vp'))
    }.width(Constants.FULL_PERCENT)
    .height($r('app.float.60vp'))
    .backgroundColor($r('app.color.dodger_blue'))
  }
}