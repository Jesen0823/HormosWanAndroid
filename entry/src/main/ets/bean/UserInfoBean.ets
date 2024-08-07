export class UserData {
  coinInfo: CoinInfo = new CoinInfo();
  userInfo: UserInfo = new UserInfo();
}

export class UserInfo {
  admin: boolean = false;
  chapterTops: [] = [];
  coinCount: number = 0;
  collectIds: [] = [];
  email: string = '';
  icon: string = '';
  id: number = 0;
  nickname: string = '';
  password: string = '';
  publicName: string = '';
  token: string = '';
  type: number = 0;
  username: string = '';
}

export class CoinInfo {
  coinCount: number = 0;
  level: number = 0;
  nickname: string = '';
  rank: string = '';
  userId: number = 0;
  username: string = '';
}