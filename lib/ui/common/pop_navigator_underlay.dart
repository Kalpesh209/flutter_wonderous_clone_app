import 'package:flutter_wonderous_clone_app/common_libs.dart';
import 'package:flutter_wonderous_clone_app/ui/common/controls/buttons.dart';

class PopNavigatorUnderlay extends StatelessWidget {
  const PopNavigatorUnderlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AppBtn.basic(
        onPressed: () => Navigator.of(context).pop(),
        semanticLabel: '',
        child: const SizedBox.expand(),
      ),
    );
  }
}
