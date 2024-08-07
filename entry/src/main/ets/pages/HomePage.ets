@Component
export default struct HomePage{
  build(){
    Column(){
      Text('首页')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }.width('100%')
  }
}