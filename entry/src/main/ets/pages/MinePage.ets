import Constants from '../common/contants/Constants'
import MineFuncView from '../view/MineFuncView'
import MineHeaderView from '../view/MineHeaderView'

@Component
export default struct MinePage{
  build(){
   Scroll(){
     Column(){
       MineHeaderView()
       MineFuncView()
     }.height(Constants.FULL_PERCENT)
   }
  }
}