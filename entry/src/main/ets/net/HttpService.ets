/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * @desc：网络请求工具类
 */

import http from '@ohos.net.http';
import ResponseResult from './ResponseResult';
import Api, { ContentType } from './Api';
import Constants from '../common/contants/Constants';
import preferences from '@ohos.data.preferences';
import * as Utils from "../utils/StringUtils";
import PreferencesUtils from '../utils/PreferencesUtils';
import HttpConfig from './HttpConfig';

PersistentStorage.PersistProp(Constants.Cookie, '');

/**
 * Initiate an HTTP GET request to the specified URL.
 *
 * @param url URL for initiating an HTTP request.
 */
export function httpRequestGet(url: string) {
  return httpRequest(url, http.RequestMethod.GET);
}

/**
 * Initiate an HTTP POST request to the specified URL.
 *
 * @param url URL for initiating an HTTP request
 * @param newsData Additional data of the request
 * @returns
 */
export function httpRequestPost(url: string, params: Object) {
  return httpRequest(url, http.RequestMethod.POST, params);
}

/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request
 * @param method Request method.
 * @param extraData Additional data of the request.
 * @returns Returns {@link ResponseResult}.
 * @desc：说明：玩安卓官网的post请求使用extraData传递数据时，后台无法收到，故使用拼接的方式。其他平台的接口extraData可以传递数据。具体原因待研究
 */


function httpRequest(url: string, method: http.RequestMethod, params?: object): Promise<ResponseResult> {

  let httpRequest = http.createHttp();
  let cookie = PreferencesUtils.getStringData(Constants.Cookie)
  httpRequest.on('headersReceive', (header) => {
    header['set-cookie'] = cookie;
    header['Cookie'] = PreferencesUtils.getStringData(Constants.Cookie)
    console.log('Jesen0823,request check1 cookie:'+PreferencesUtils.getStringData(Constants.Cookie));
    console.log('Jesen0823,request check2 cookie:'+AppStorage.Get(Constants.Cookie));
    console.info('Jesen0823,header: ' + JSON.stringify(header));
  });

  let responseResult = httpRequest.request(url, {
    method: method,
    extraData: params,
    header: {
      'Content-Type': ContentType.JSON,
      'Cookie': AppStorage.Get(Constants.Cookie),
    },
    readTimeout: HttpConfig.HTTP_READ_TIMEOUT,
    connectTimeout: HttpConfig.HTTP_READ_TIMEOUT,
  });
  let serverData = new ResponseResult();

  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === HttpConfig.HTTP_CODE_200) {
      console.log('Jesen0823,responseResult value:'+JSON.stringify(value));
      // Obtains the returned data.
      let result = `${value.result}`;
      if (url.includes("login") && !Utils.isEmpty(value.header['set-cookie']) || url.includes("register") && !Utils.isEmpty(value.header['set-cookie'])) {
        console.log('Jesen0823,HttpService,AppStorage.Set(), url: '+url);
        AppStorage.Set(Constants.Cookie, `loginUserName=${params['username']};loginUserPassword=${params['password']}${value.header['set-cookie']}`);
        PreferencesUtils.putStringData(Constants.Cookie, `loginUserName=${params['username']};loginUserPassword=${params['password']}${value.header['set-cookie']}`);
      }
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.errorCode === HttpConfig.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.errorCode = resultJson.errorCode;
      serverData.errorMsg = resultJson.errorMsg;
    } else {
      serverData.errorMsg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.errorMsg = $r('app.string.http_error_message');
    return serverData;
  });
}
