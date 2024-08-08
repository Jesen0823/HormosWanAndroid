import router from '@ohos.router'
import { CoinData, CoinItem } from '../bean/CoinBean';
import { RankData, RankItem } from '../bean/RankBean';
import Constants from '../common/contants/Constants';
import MineInfoItemView from '../view/MineInfoItemView';
import TitleBar from '../view/TitleBar';
import userInfoViewModel from '../viewmodel/UserInfoViewModel';

@Preview
@Entry
@Component
struct UserInfoPage {
  @State routerParams: object = router.getParams();
  @State title: string = '';
  @State coinData: CoinData = new CoinData();
  @State coinListData: CoinItem[] = [];
  @State rankData: RankData = new RankData;
  @State rankListData: RankItem[] = [];

  aboutToAppear() {
    switch (this.routerParams['title']) {
      case Constants.RANK:
        this.title = '积分榜';
        this.getRankData(1);
        break;
      case Constants.COIN:
        this.title = '个人积分';
        this.getCoinData(1);
        break;
      default:
        this.title = '其他';
        break;
    }
  }

  getRankData(page:number){
    userInfoViewModel.getRank(page).then((data:RankData)=>{
      this.rankData = data;
      this.rankListData = data.datas;
    })
  }

  getCoinData(page: number) {
    userInfoViewModel.getCoin(page).then((data: CoinData) => {
      this.coinData = data;
      this.coinListData = data.datas;
    })
  }

  @Builder
  listRankUI(){
    List({space:10}){
      ForEach(this.rankListData,(item:RankItem,index)=>{
        ListItem(){
          MineInfoItemView({
            param1: `排名：${item.rank}`,
            param2: `用户名：${item.username}`,
            param3: `用户等级：${item.level}`,
            param4: `用户积分：${item.coinCount}`,
          })
        }
      })
    }
  }

  @Builder
  listCoinUI() {
    List({ space: 10 }) {
      ForEach(this.coinListData, (item: CoinItem, index) => {
        ListItem() {
          MineInfoItemView({
            param1: `类型：${item.reason}`,
            param2: `获得积分：${item.coinCount}`,
            param3: `用户等级：${item.desc}`,
          })
        }
      })
    }
  }

  build() {
    Column() {
      TitleBar({ title: this.title })
      if (this.routerParams['title'] === Constants.RANK) {
        this.listRankUI()
      } else if (this.routerParams['title'] === Constants.COIN) {
        this.listCoinUI()
      }
    }
  }
}