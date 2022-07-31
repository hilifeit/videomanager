import 'package:videomanager/screens/others/exporter.dart';

class ResponsiveLayout {
  ResponsiveLayout._();

  static bool isMobile = false, isTablet = false, isDesktop = false;

  static setMobile() {
    isMobile = true;
    isTablet = false;
    isDesktop = false;
  }

  static setTablet() {
    isMobile = false;
    isTablet = true;
    isDesktop = false;
  }

  static setDesktop() {
    isMobile = false;
    isTablet = false;
    isDesktop = true;
  }

  static checkWidth(BoxConstraints constraints) {
    if (constraints.maxWidth < 550) {
      ResponsiveLayout.setMobile();
      return const Size(414, 896);
    } else if (constraints.maxWidth < 1100) {
      ResponsiveLayout.setTablet();
      return const Size(768, 1024);
    } else {
      ResponsiveLayout.setDesktop();
      return const Size(1920, 1080);
    }
  }
}
