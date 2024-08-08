import Constants from '../common/contants/Constants';
import * as Utils from '../utils/StringUtils'

@Preview
@Component
export default struct MineInfoItemView {
  param1: string = 'param1';
  param2: string = 'param2';
  param3: string = 'param3';
  param4: string = 'param4';

  build() {
    Column({ space: 5 }) {
      Text(this.param1)
      Text(this.param2)
      Text(this.param3)
      if (!Utils.isEmpty(this.param4)) {
        Text(this.param4)
      }
    }.width(Constants.FULL_PERCENT)
    .borderRadius(5)
    .padding({ left: 5, right: 5, top: 10, bottom: 10 })
    .backgroundColor($r('app.color.white_smoke'))
  }
}