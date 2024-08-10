// 配合LazyForEach组件

export class BaseDataSource implements IDataSource {
  private listenerList:DataChangeListener[]=[];

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listenerList.indexOf(listener);
    if(pos>=0){
      console.info('Jesen0823,remove listener');
      this.listenerList.splice(pos,1);
    }
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    console.info('Jesen0823,add listener');
    this.listenerList.push(listener);
  }

  getData(index: number) {
  }

  totalCount(): number {
    return 0;
  }
}