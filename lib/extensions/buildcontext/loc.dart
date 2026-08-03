import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_tutorial_first_sample_project/l10n/app_localizations.dart';

extension Localization on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
