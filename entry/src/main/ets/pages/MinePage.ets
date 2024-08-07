@Component
export default struct MinePage{
  build(){
    Column(){
      Text('我的')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }.width('100%')
  }
}