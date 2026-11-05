import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, this.dark = false});
  final String title;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final fg = dark ? Colors.white : null;
    return Scaffold(
      backgroundColor: dark ? Colors.black : null,
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: fg)),
        backgroundColor: dark ? Colors.black : null,
        iconTheme: IconThemeData(color: fg),
      ),
      body: Center(child: Text(l.comingSoon, style: TextStyle(color: fg))),
    );
  }
}
