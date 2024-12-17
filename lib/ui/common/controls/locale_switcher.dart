import 'package:flutter_wonderous_clone_app/common_libs.dart';
import 'package:flutter_wonderous_clone_app/logic/settings_logic.dart';
import 'package:flutter_wonderous_clone_app/main.dart';
import 'package:flutter_wonderous_clone_app/ui/common/controls/buttons.dart';

class LocaleSwitcher extends StatelessWidget with GetItMixin {
  LocaleSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = watchX((SettingsLogic s) => s.currentLocale);
    Future<void> handleSwapLocale() async {
      final newLocale = Locale(locale == 'en' ? 'zh' : 'en');
      await settingsLogic.changeLocale(newLocale);
    }

    return AppBtn.from(
        text: $strings.localeSwapButton,
        onPressed: handleSwapLocale,
        padding: EdgeInsets.all($styles.insets.sm));
  }
}
