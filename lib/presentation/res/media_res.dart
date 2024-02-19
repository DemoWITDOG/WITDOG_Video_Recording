import 'dart:ui';

class MediaRes{
  const MediaRes._();

  // image getter
  static String get serviceInfoImage => _serviceInfoImage;
  static String get logoImage => _logoImage;
  static String get recordHomeImage =>_recordHomeImage;
  static String get recordBodyTopImage => _recordBodyTopImage;
  static String get recordStartImage => _recordStartImage;
  static String get recordBodyTopStartImage => _recordBodyTopStartImage;

  // color getter
  static int get blueColor => _blueColor;
  static int get blackColor => _blockColor;
  static int get appbarGrayColor => _appBarGrayColor;
  static int get redColor => _redColor;
  static int get whiteGrayColor => _whiteGrayColor;
  static int get whiteGrayTextColor => _whiteGrayTextColor;
  static int get mugwort => _mugwort;
  static int get whiteColor => _whiteColor;

  // font getter
  static FontWeight get mediumBold => _mediumBold;
  static FontWeight get semiBold => _semiBold;
  static FontWeight get bold => _bold;
  static FontWeight get extraBold => _extraBold;

  // image Path
  static const _baseLogin = 'assets/images/login_images';
  static const _baseRecord = 'assets/images/record_images';
  static const _baseHome = 'assets/images/home_images';

  static const _logoImage = '$_baseLogin/WITDOG.png';
  static const _serviceInfoImage = '$_baseHome/recording_home.png';

  static const _recordHomeImage = '$_baseRecord/record_home_image.png';
  static const _recordBodyTopImage = '$_baseRecord/recording_body_top_image.png';
  static const _recordStartImage = '$_baseRecord/record_home_top_image.png';
  static const _recordBodyTopStartImage = '$_baseRecord/recording_body_top_start_image.png';

  // color
  static const _blueColor = 0xff0094FF;
  static const _blockColor = 0xff000000;
  static const _redColor = 0xffED4545;
  static const _whiteGrayColor = 0xffE0E0E0;
  static const _whiteGrayTextColor = 0xffC1C1C1;
  static const _whiteColor = 0xffffffff;
  static const _appBarGrayColor = 0xff7C7C7C;

  // 쑥색
  static const _mugwort = 0xff6A9E85;

  // fontWeight
  static const _mediumBold = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  static const _extraBold = FontWeight.w900;

  // fontSize
  static double get fontSize12 => 12.0;
  static double get fontSize14 => 14.0;
  static double get fontSize16 => 16.0;
  static double get fontSize18 => 18.0;
  static double get fontSize20 => 20.0;
  static double get fontSize24 => 24.0;
  static double get fontSize28 => 28.0;
  static double get fontSize32 => 32.0;
  static double get fontSize36 => 36.0;

}