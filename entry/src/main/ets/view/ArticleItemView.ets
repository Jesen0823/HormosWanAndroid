import { Article } from '../bean/ArticleBean'
import Constants from '../common/contants/Constants';
import * as Utils from '../utils/StringUtils'

@Preview
@Component
export default struct ArticleItemView {
  article: Article = new Article();
  @State isTop: boolean = false;
  @State hasTag: boolean = false;
  @State tag: string = '';
  @State author: string | number = '';
  @State title: string = '';
  @State desc: string = '';
  @State hasPic: boolean = false;
  @State hasSuperChapterName: boolean = false;
  @State superChapterName: string = '';
  @State hasChapterName: boolean = false;
  @State chapterName: string = '';

  aboutToAppear() {
    let item = this.article;
    this.isTop = item.isTop;
    this.hasTag = !Utils.isEmpty(item.tags as []);
    this.tag = !this.hasTag ? '' : item.tags[0].name;
    this.author = Utils.isEmpty(item.author) ? Utils.isEmpty(item.shareUser) ? '' : item.shareUser : item.author;
    this.title = Utils.formatHtml(item.title);
    this.desc = Utils.formatHtml(item.desc);
    this.hasPic = !Utils.isEmpty(item.envelopePic);
    this.hasSuperChapterName = !Utils.isEmpty(item.superChapterName);
    this.superChapterName = Utils.isEmpty(item.superChapterName) ? '' : Utils.formatHtml(item.superChapterName);
    this.hasChapterName = !Utils.isEmpty(item.chapterName);
    this.chapterName = Utils.isEmpty(item.chapterName) ? '' : Utils.formatHtml(item.chapterName);
  }

  build() {
    Column() {
      // line 1
      Row() {
        if (this.hasTag) {
          Text(this.tag)
            .height($r('app.float.23vp'))
            .fontSize($r('app.float.12fp'))
            .textAlign(TextAlign.Center)
            .borderRadius($r('app.float.3vp'))
            .fontColor($r('app.color.white'))
            .backgroundColor($r('app.color.red'))
            .padding({
              left: $r('app.float.10vp'),
              right: $r('app.float.10vp'),
              top: $r('app.float.5vp'),
              bottom: $r('app.float.5vp')
            })
        }

        Row() {
          Image($r('app.media.ic_mine_normal'))
            .width($r('app.float.18vp'))
            .height($r('app.float.18vp'))
          Text(this.author.toString())
            .margin({ left: $r('app.float.5vp') })
        }.margin({ left: $r('app.float.5vp'), right: $r('app.float.5vp') })

        Row() {
          Image($r('app.media.ic_clock'))
            .width($r('app.float.18vp'))
            .height($r('app.float.18vp'))
          Text(this.article.niceDate)
        }
      }.width(Constants.FULL_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)

      // line 2
      Flex({ direction: FlexDirection.Row }) {
        Column() {
          Text(this.title)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontSize($r('app.float.18fp'))
            .fontColor(Color.Black)
            .align(Alignment.TopStart)

          Text(this.desc)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor(Color.Gray)
            .align(Alignment.TopStart)
        }.flexGrow(1)
        .alignItems(HorizontalAlign.Start)

        if (this.hasPic) {
          Image(this.article.envelopePic)
            .width($r('app.float.60vp'))
            .height('100%')
        }
      }.height($r('app.float.80vp'))
      .margin({ top: $r('app.float.5vp') })

      // line 3
      Row() {
        if (this.isTop) {
          Text($r('app.string.topTag'))
            .height($r('app.float.23vp'))
            .fontSize($r('app.float.12fp'))
            .borderRadius($r('app.float.3vp'))
            .textAlign(TextAlign.Center)
            .fontColor($r('app.color.white'))
            .backgroundColor($r('app.color.dark_orange'))
            .padding({
              left: $r('app.float.10vp'),
              right: $r('app.float.10vp'),
              top: $r('app.float.5vp'),
              bottom: $r('app.float.5vp')
            })
            .margin({ right: $r('app.float.10vp') })
        }

        if (this.hasSuperChapterName) {
          Text(this.superChapterName)
            .height($r('app.float.23vp'))
            .fontSize($r('app.float.12fp'))
            .borderRadius($r('app.float.3vp'))
            .textAlign(TextAlign.Center)
            .fontColor($r('app.color.white'))
            .backgroundColor($r('app.color.olive'))
            .padding({
              left: $r('app.float.10vp'),
              right: $r('app.float.10vp'),
              top: $r('app.float.5vp'),
              bottom: $r('app.float.5vp')
            })
            .margin({ right: $r('app.float.10vp') })
        }
        if (this.hasChapterName) {
          Text(this.chapterName)
            .height($r('app.float.23vp'))
            .fontSize($r('app.float.12fp'))
            .borderRadius($r('app.float.3vp'))
            .textAlign(TextAlign.Center)
            .fontColor($r('app.color.white'))
            .backgroundColor($r('app.color.teal'))
            .padding({
              left: $r('app.float.10vp'),
              right: $r('app.float.10vp'),
              top: $r('app.float.5vp'),
              bottom: $r('app.float.5vp')
            })
            .margin({ right: $r('app.float.10vp') })
        }
      }.width(Constants.FULL_PERCENT)
      .justifyContent(FlexAlign.Start)
      .margin({ top: $r('app.float.5vp') })
    }
    .width(Constants.FULL_PERCENT)
    .padding({
      top: $r('app.float.5vp'),
      bottom: $r('app.float.5vp'),
      left: $r('app.float.10vp'),
      right: $r('app.float.10vp')
    })
    .borderWidth(0.5)
    .borderColor(Color.Gray)
    .backgroundColor('#FFF1F3F5')
  }
}