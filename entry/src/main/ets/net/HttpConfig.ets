export default class HttpConfig {
  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: number = 0;

  /**
   * The off set coefficient.
   */
  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;

  /**
   * The page size.
   */
  static readonly PAGE_SIZE: number = 10;

  /**
   * The refresh and load height.
   */
  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;

  /**
   * Gt tab data current page.
   */
  static readonly GET_TAB_DATA_CURRENT_PAGE: number = 1;

  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;
  static readonly HTTP_CODE_0: number = 0;
  /**
   * The animation delay time.
   */
  static readonly DELAY_ANIMATION_DURATION: number = 300;

  /**
   * The delay time.
   */
  static readonly DELAY_TIME: number = 1000;

  /**
   * The animation duration.
   */
  static readonly ANIMATION_DURATION: number = 2000;

  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;

  /**
   * Content maxLine.
   */
  static readonly CONTENT_MAX_LINE: number = 3;

  /**
   * List space.
   */
  static readonly LIST_SPACE: number = 12;

  /**
   * Item img space.
   */
  static readonly ITEM_IMG_SPACE: number = 8;

  /**
   * Type font weight.
   */
  static readonly TYPE_FONT_WEIGHT: number = 700;

  /**
   * Title font weight.
   */
  static readonly TITLE_FONT_WEIGHT: number = 500;

  /**
   * Desc font weight.
   */
  static readonly DESC_FONT_WEIGHT: number = 400;

  /**
   * Type aspect ratio.
   */
  static readonly TYPE_ASPECT_RATIO: number = 2;

  /**
   * Desc opacity.
   */
  static readonly DESC_OPACITY: number = 0.6;

  /**
   * 100 percent.
   */
  static readonly FULL_PERCENT: string = '100%';

  /**
   * Divider width.
   */
  static readonly DIVIDER_WIDTH: string = '90%';

  /**
   * Release title.
   */
  static readonly RELEASE_TITLE: string = '新闻发布';
}

/**
 * The RefreshConstant constants.
 */
export const enum RefreshConstant {
  DELAY_PULL_DOWN_REFRESH = 50,
  CLOSE_PULL_DOWN_REFRESH_TIME = 150,
  DELAY_SHRINK_ANIMATION_TIME = 500
}

/**
 * The refresh state enum.
 */
export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}

/**
 * The newsList state enum.
 */
export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}

/**
 * The file upload state enum.
 */
export const enum UploadingState {
  COMPLETE = 'complete',
  FAIL = 'fail'
}

/**
 * The request method enum.
 */
export const enum RequestMethod {
  POST = 'POST',
  GET = 'GET'
}
