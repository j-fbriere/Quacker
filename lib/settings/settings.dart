import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:quacker/generated/l10n.dart';
import 'package:quacker/home/home_screen.dart';
import 'package:quacker/settings/_about.dart';
import 'package:quacker/settings/_data.dart';
import 'package:quacker/settings/_general.dart';
import 'package:quacker/settings/_home.dart';
import 'package:quacker/settings/_theme.dart';
import 'package:package_info/package_info.dart';

class SettingsScreen extends StatefulWidget {
  final String? initialPage;

  const SettingsScreen({Key? key, this.initialPage}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  PackageInfo _packageInfo = PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');
  String _legacyExportPath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appVersion = 'v${_packageInfo.version}+${_packageInfo.buildNumber}';

    var pages = [
      NavigationPage('general', (c) => L10n.of(c).general, MaterialSymbols.settings),
      NavigationPage('home', (c) => L10n.of(c).home, MaterialSymbols.home),
      NavigationPage('theme', (c) => L10n.of(c).theme, MaterialSymbols.format_paint),
      NavigationPage('data', (c) => L10n.of(c).data, MaterialSymbols.storage),
      NavigationPage('about', (c) => L10n.of(c).about, MaterialSymbols.help),
    ];

    var initialPage = pages.indexWhere((element) => element.id == widget.initialPage);
    if (initialPage == -1) {
      initialPage = 0;
    }

    return ScaffoldWithBottomNavigation(
      initialPage: initialPage,
      pages: pages,
      builder: (scrollController) {
        return [
          const SettingsGeneralFragment(),
          const SettingsHomeFragment(),
          const SettingsThemeFragment(),
          SettingsDataFragment(legacyExportPath: _legacyExportPath),
          SettingsAboutFragment(appVersion: appVersion)
        ];
      },
    );
  }
}
