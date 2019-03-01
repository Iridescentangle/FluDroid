class HttpService{
  static const String WANANDROID_LOGIN = "http://www.wanandroid.com/user/login";
  static const String WANANDROID_BASE_URL = "http://www.wanandroid.com/";
  static const String WANANDROID_LOGOUT = "http://www.wanandroid.com/user/logout/json";
  static const String WANANDROID_UNCOLLECT = "http://www.wanandroid.com/lg/uncollect/~/json";
  static const String WANANDROID_REGISTER = 'http://www.wanandroid.com/user/register';
  static const String WANANDROID_FAVORITE = 'http://www.wanandroid.com/lg/collect/list/~/json';
  static const String WANANDROID_COLLECT = 'http://www.wanandroid.com/lg/collect/~/json';
  static const String WANANDROID_BANNER = 'http://www.wanandroid.com/banner/json';
  static const String WANANDROID_HOT_KEY = 'http://www.wanandroid.com//hotkey/json';
  static const String WANANDROID_SEARCH = 'http://www.wanandroid.com/article/query/~/json';
  static const String DOUBAN_HOT_MOVIE = 'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=~&start=0&count=100&client=&udid=';
}
const douban_base_url = 'https://api.douban.com/v2/movie/';
const douban_paths = {
  'search':douban_base_url+"search?q=",//电影搜索

};