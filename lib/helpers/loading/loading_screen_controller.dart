import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen closeLoading;
  final UpdateLoadingScreen updateLoading;

  const LoadingScreenController({
    required this.closeLoading,
    required this.updateLoading,
  });
}
