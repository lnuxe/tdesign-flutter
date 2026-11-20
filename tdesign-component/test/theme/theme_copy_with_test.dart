import 'package:flutter_test/flutter_test.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

void main() {
  const override = Color(0xFFE34D59);

  test('copyWith keeps the light/dark pair (issue #1228)', () {
    final theme = TThemeData.defaultData();
    expect(theme.dark, isNotNull);

    final custom = theme.copyWith(colorMap: {'brandColor': override});

    // 亮暗成对的主题复制后必须仍然成对，否则 TThemeBuilder.dark 会静默回退
    // 到亮色 Token（token.dark ?? token）。
    expect(custom.dark, isNotNull);
    expect(custom.light, same(custom));
    expect(custom.dark!.light, same(custom));
  });

  test('copyWith applies the same overrides to the dark theme', () {
    final theme = TThemeData.defaultData();
    final custom = theme.copyWith(colorMap: {'brandColor': override});

    expect(custom.colorMap['brandColor'], override);
    expect(custom.dark!.colorMap['brandColor'], override);
  });

  test('TThemeBuilder.dark builds from the dark tokens after copyWith', () {
    final theme = TThemeData.defaultData();
    final custom = theme.copyWith(colorMap: {'brandColor': override});

    final material = TThemeBuilder.dark(custom);

    expect(material.colorScheme.surface, theme.dark!.bgColorContainer);
  });
}
