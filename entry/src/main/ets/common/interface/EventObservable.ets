import { ObservableData } from './ObservableData';
class EventObservable{
  observableLoginState = new ObservableData<Boolean>(false);
}
export default new EventObservable;