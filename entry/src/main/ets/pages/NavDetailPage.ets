import router from '@ohos.router'

@Entry
@Component
export default struct NavDetailPage{
  @State routerParams:object = router.getParams();

  aboutToAppear(){

  }

  build(){
    Text(`${this.routerParams['data']}`)
  }
}