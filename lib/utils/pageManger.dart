import 'package:flutter/material.dart';

import 'pages.dart';

class GalleryDemo {
  const GalleryDemo({
    @required this.title,
    @required this.icon,
    this.subtitle,
    @required this.routeName,
    @required this.buildRoute,
  })  : assert(title != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String title;
  final IconData icon;
  final String subtitle;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

List<GalleryDemo> _buildGalleryDemos() {
  final List<GalleryDemo> galleryDemos = <GalleryDemo>[
    // Demos
    new GalleryDemo(
      title: 'register',
      subtitle: 'register user',
      icon: IconData(0xe90c),
      routeName: Register.routeName,
      buildRoute: (BuildContext context) => new Register(),
    ),
  ];

  // Keep Pesto around for its regression test value. It is not included
  // in (release builds) the performance tests.
//  assert(() {
//    galleryDemos.insert(0,
//      new GalleryDemo(
//        title: 'Pesto',
//        subtitle: 'Simple recipe browser',
//        icon: Icons.adjust,
//        category: _kDemos,
//        routeName: PestoDemo.routeName,
//        buildRoute: (BuildContext context) => const PestoDemo(),
//      ),
//    );
//    return true;
//  }());

  return galleryDemos;
}

final List<GalleryDemo> kAllGalleryDemos = _buildGalleryDemos();
