@Component
export default struct ProjectPage{
  build(){
    Column(){
      Text('项目')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }.width('100%')
  }
}