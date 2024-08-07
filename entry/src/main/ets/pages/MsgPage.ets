@Component
export default struct MsgPage{
  build(){
    Column(){
      Text('消息')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }.width('100%')
  }
}