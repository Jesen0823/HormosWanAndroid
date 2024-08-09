import { MsgItem } from '../bean/MsgBean';
import Constants from '../common/contants/Constants';

@Preview
@Component
export default struct MsgItemView{
  msgItem:MsgItem = new MsgItem();
  @State msg:string = '';

  build(){
    Column(){
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Row() {
          Image($r('app.media.ic_mine_normal'))
            .width($r('app.float.18vp'))
            .height($r('app.float.18vp'))
          Text(this.msgItem.fromUser)
            .margin({ left: $r('app.float.5vp') }) //2-author
        }
        .margin({ left: $r('app.float.5vp'), right: $r('app.float.5vp') })

        Text(this.msgItem.tag)
          .fontSize($r('app.float.12fp'))
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .borderRadius($r('app.float.3vp'))
          .fontColor($r('app.color.white'))
          .backgroundColor($r('app.color.fire_brick'))
          .padding({
            left: $r('app.float.10vp'),
            right: $r('app.float.10vp'),
          })

        Row() {
          Image($r('app.media.ic_clock'))
            .width($r('app.float.18vp'))
            .height($r('app.float.18vp'))
          Text(this.msgItem.niceDate)
            .margin({ left: $r('app.float.5vp') }) //2-author
        }
        .margin({ left: $r('app.float.5vp'), right: $r('app.float.5vp') })
      }

      // 标题
      Text(this.msgItem.title)
        .fontSize($r('app.float.14fp'))
        .textAlign(TextAlign.Start)
        .borderRadius($r('app.float.3vp'))
        .fontColor($r('app.color.white'))
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width(Constants.FULL_PERCENT)
        .borderRadius(6)
        .backgroundColor($r('app.color.royal_blue'))
        .margin({ top: $r('app.float.10vp') })
        .padding({
          left: $r('app.float.10vp'),
          right: $r('app.float.10vp'),
          top: $r('app.float.5vp'),
          bottom: $r('app.float.5vp')
        })

      Text(this.msgItem.message)
        .textAlign(TextAlign.Start)
        .width(Constants.FULL_PERCENT)
        .maxLines(3)
        .margin({ top: $r('app.float.10vp') })
    }
    .padding(10)
    .backgroundColor($r('app.color.white_smoke'))
    .borderWidth(5)
    .borderColor($r('app.color.light_gray'))
  }
}