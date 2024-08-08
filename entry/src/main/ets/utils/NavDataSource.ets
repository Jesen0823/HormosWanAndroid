import { NavItem } from '../bean/NavBean';
import { BaseDataSource } from '../common/interface/BaseDataSource';

class NavDataSource extends BaseDataSource{
  private dataArray:NavItem[] =[];

  public totalCount():number{
    return this.dataArray.length;
  }

  public getData(index:number):NavItem{
    return this.dataArray[index];
  }

  public  pushData(data:NavItem){
    this.dataArray.push(data);
  }
}