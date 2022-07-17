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
}
