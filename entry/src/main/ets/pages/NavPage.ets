@Component
export default struct NavPage{
  build(){
    Column(){
      Text('导航')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }.width('100%')
  }
}