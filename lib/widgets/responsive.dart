import 'package:flutter/material.dart';

/// Device breakpoints for responsive design
class Breakpoints {
  static const double mobileSmall = 320;  // Old phones (iPhone 5, SE 1st gen)
  static const double mobileMedium = 375; // Standard phones (iPhone 6-8, X-14)
  static const double mobileLarge = 414;  // Large phones (iPhone Plus, Pro Max)
  static const double tablet = 768;       // Tablets
  static const double laptop = 1024;      // Laptops
  static const double desktop = 1280;     // Desktops
  static const double desktopLarge = 1440; // Large desktops
}

/// Device type enumeration
enum DeviceType {
  mobileSmall,  // < 360px
  mobile,       // 360-599px
  tablet,       // 600-899px
  laptop,       // 900-1199px
  desktop,      // >= 1200px
}

/// Responsive utilities for the app
class Responsive {
  final BuildContext context;
  late final double width;
  late final double height;
  late final DeviceType deviceType;

  Responsive(this.context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    deviceType = _getDeviceType();
  }

  DeviceType _getDeviceType() {
    if (width < 360) return DeviceType.mobileSmall;
    if (width < 600) return DeviceType.mobile;
    if (width < 900) return DeviceType.tablet;
    if (width < 1200) return DeviceType.laptop;
    return DeviceType.desktop;
  }

  bool get isMobileSmall => deviceType == DeviceType.mobileSmall;
  bool get isMobile => deviceType == DeviceType.mobile || isMobileSmall;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isLaptop => deviceType == DeviceType.laptop;
  bool get isDesktop => deviceType == DeviceType.desktop;

  bool get isMobileOrSmaller => isMobile || isMobileSmall;
  bool get isTabletOrSmaller => isMobileOrSmaller || isTablet;
  bool get isLaptopOrSmaller => isTabletOrSmaller || isLaptop;

  /// Get value based on device type
  T value<T>({
    required T mobile,
    T? mobileSmall,
    T? tablet,
    T? laptop,
    T? desktop,
  }) {
    switch (deviceType) {
      case DeviceType.mobileSmall:
        return mobileSmall ?? mobile;
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.laptop:
        return laptop ?? tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? laptop ?? tablet ?? mobile;
    }
  }

  /// Horizontal padding based on screen size
  EdgeInsets get pagePadding {
    return EdgeInsets.symmetric(
      horizontal: value(
        mobileSmall: 16.0,
        mobile: 20.0,
        tablet: 40.0,
        laptop: 60.0,
        desktop: 80.0,
      ),
    );
  }

  /// Section vertical spacing
  double get sectionSpacing {
    return value(
      mobileSmall: 48.0,
      mobile: 56.0,
      tablet: 72.0,
      laptop: 88.0,
      desktop: 100.0,
    );
  }

  /// Max content width
  double get maxContentWidth {
    return value(
      mobile: double.infinity,
      tablet: 720.0,
      laptop: 900.0,
      desktop: 1080.0,
    );
  }

  /// Font scale factor for responsive typography
  double get fontScale {
    return value(
      mobileSmall: 0.85,
      mobile: 0.92,
      tablet: 0.96,
      laptop: 1.0,
      desktop: 1.0,
    );
  }

  /// Grid columns for layouts
  int get gridColumns {
    return value(
      mobileSmall: 1,
      mobile: 1,
      tablet: 2,
      laptop: 2,
      desktop: 2,
    );
  }
}

/// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Responsive responsive) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive(context));
  }
}

/// Extension on BuildContext for easy access
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}
