export class ObservableData<T> {
  private data: T;
  private observers: Function[] = [];

  constructor(data: T) {
    this.data = data;
  }

  addObserver(observer: Function) {
    this.observers.push(observer);
  }

  setData(value: T) {
    this.data = value;
    this.notifyObservers();
  }

  getData(): T {
    return this.data
  }

  private notifyObservers() {
    this.observers.forEach(observer => {
      observer(this.data);
    });
  }
}
