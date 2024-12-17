import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_wonderous_clone_app/common_libs.dart';
import 'package:flutter_wonderous_clone_app/logic/collectibles_logic.dart';
import 'package:flutter_wonderous_clone_app/logic/data/collectible_data.dart';
import 'package:flutter_wonderous_clone_app/logic/data/wonder_data.dart';
import 'package:flutter_wonderous_clone_app/logic/data/wonder_type.dart';
import 'package:flutter_wonderous_clone_app/main.dart';
import 'package:flutter_wonderous_clone_app/router.dart';
import 'package:flutter_wonderous_clone_app/ui/common/centered_box.dart';
import 'package:flutter_wonderous_clone_app/ui/common/controls/app_header.dart';
import 'package:flutter_wonderous_clone_app/ui/common/controls/app_image.dart';
import 'package:flutter_wonderous_clone_app/ui/common/controls/buttons.dart';
import 'package:flutter_wonderous_clone_app/ui/common/modals/app_modals.dart';

part 'widgets/_collectible_image.dart';
part 'widgets/_collection_footer.dart';
part 'widgets/_collection_list.dart';
part 'widgets/_collection_list_card.dart';
part 'widgets/_newly_discovered_items_btn.dart';

class CollectionScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  CollectionScreen({required this.fromId, super.key});

  final String fromId;

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with GetItStateMixin {
  final GlobalKey _scrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final states = collectiblesLogic.statesById.value;
    if (widget.fromId.isNotEmpty &&
        states[widget.fromId] == CollectibleState.discovered) {
      scheduleMicrotask(() => _scrollToTarget(false));
    }
  }

  void _scrollToTarget([bool animate = true]) {
    if (_scrollKey.currentContext != null) {
      Scrollable.ensureVisible(_scrollKey.currentContext!,
          alignment: 0.15, duration: animate ? 300.ms : 0.ms);
    }
  }

  void _handleReset() async {
    String msg = $strings.collectionPopupResetConfirm;
    final result = await showModal(context, child: OkCancelModal(msg: msg));
    if (result == true) {
      collectiblesLogic.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild when collectible states change
    watchX((CollectiblesLogic o) => o.statesById);
    int discovered = collectiblesLogic.discoveredCount;
    int explored = collectiblesLogic.exploredCount;
    int total = collectiblesLogic.all.length;

    return ColoredBox(
      color: $styles.colors.greyStrong,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeader(
                    title: $strings.collectionTitleCollection,
                    isTransparent: true),
                _NewlyDiscoveredItemsBtn(
                    count: discovered, onPressed: _scrollToTarget),
                Flexible(
                  child: _CollectionList(
                    fromId: widget.fromId,
                    scrollKey: _scrollKey,
                    onReset: discovered + explored > 0 ? _handleReset : null,
                  ),
                ),
              ],
            ),
          ),
          _CollectionFooter(count: discovered + explored, total: total),
        ],
      ),
    );
  }
}
