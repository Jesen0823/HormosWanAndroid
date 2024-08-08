import Constants from '../common/contants/Constants';

interface FuncModel {
  'name': string;
  'backgroundColor': Color;
}

@Preview
@Component
export default struct MineFuncView {
  @State bgColors: Color[] = [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink, Color.Grey, Color.Blue,
  Color.Brown];
  gradData: FuncModel[] = [
    {
      name: "工具",
      backgroundColor: Color.Blue
    },
    {
      name: "问答",
      backgroundColor: Color.Brown
    },
    {
      name: "消息",
      backgroundColor: Color.Pink
    },
    {
      name: "课程",
      backgroundColor: Color.Green
    },
    {
      name: "待办",
      backgroundColor: Color.Red
    },
    {
      name: "文章分享",
      backgroundColor: Color.Orange
    },
  ];
  @State currentBackground: string = '';

  build() {
    Column() {
      Text('常用功能')
        .fontSize($r('app.float.20fp'))
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: $r('app.float.10vp'),top:$r('app.float.12vp') })

      GridRow({ columns: 3 }) {
        ForEach(this.gradData, (item: FuncModel, index) => {
          GridCol() {
            Row() {
              Text(`${item.name}`)
                .textAlign(TextAlign.Center)
                .width(Constants.FULL_PERCENT)
                .margin($r('app.float.6vp'))
            }.backgroundColor(item.backgroundColor)
          }
        })
      }
      .width(Constants.FULL_PERCENT)
      .height($r('app.float.120vp'))
      .onBreakpointChange((breakPoint) => {
        this.currentBackground = breakPoint;
      })
    }
    .height(600)
    .alignItems(HorizontalAlign.Start)
    .padding({ left: $r('app.float.10vp'), right: $r('app.float.10vp') })
    .width(Constants.FULL_PERCENT)
  }
}