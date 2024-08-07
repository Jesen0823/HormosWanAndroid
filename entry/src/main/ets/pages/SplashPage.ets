import router from '@ohos.router';
import Constants from '../common/contants/Constants';

@Entry
@Component
struct SplashPage {
  @State countDown: number = 2;
  @State showSwiper: boolean = false;
  private timer: number = -1;

  aboutToAppear() {
    setTimeout(() => {
      this.showSwiper = true;
      this.startTime();
    }, 3000);
  }

  startTime() {
    this.timer = setInterval(() => {
      this.countDown--;
      if (this.countDown === 0) {
        this.clearTime();
        this.jumpToMain();
      }
    }, 1000);
  }

  clearTime() {
    if (this.timer != -1) {
      clearInterval(this.timer);
      this.timer = -1;
    }
  }

  jumpToMain() {
    this.clearTime();
    router.replaceUrl({ url: 'pages/MainPage' })
  }

  aboutToDisappear() {
    this.clearTime();
  }

  build() {
    Stack() {
      Image($r('app.media.splash_pic'))
        .width(Constants.FULL_PERCENT)
        .height(Constants.FULL_PERCENT)
      Image($r('app.media.ic_logo'))
        .width($r('app.float.140vp'))
        .height($r('app.float.140vp'))
        .offset({
          y: Constants.PERCENTAGE_35
        })
        .objectFit(ImageFit.Contain)
      Column() {
        Text($r('app.string.app_name'))
          .fontColor(Color.White)
          .fontSize($r('app.float.font_size_24fp'))
          .fontWeight(FontWeight.Medium)
      }.offset({ y: Constants.PERCENTAGE_25 })
    }
    .height(Constants.FULL_SIZE)
    .width(Constants.FULL_SIZE)
  }
}