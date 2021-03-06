import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../contracts/misc/actionItem.dart';
import '../../helpers/deviceHelper.dart';
import '../../helpers/navigationHelper.dart';
import 'appBar.dart';
import 'shortcutActionButton.dart';

class AppBarForSubPage extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final Widget title;
  final List<ActionItem> actions;
  final List<ActionItem> shortcutActions;
  final bool showHomeAction;
  final bool showBackAction;
  final preferredSize;
  final bottom;
  final backgroundColor;
  static final kMinInteractiveDimensionCupertino = 44.0;

  AppBarForSubPage(this.title, this.actions, this.showHomeAction,
      this.showBackAction, this.shortcutActions,
      {this.bottom, this.backgroundColor})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
        super();

  @override
  Widget build(BuildContext context) =>
      _appBarForAndroid(context, title, actions, shortcutActions);

  Widget _appBarForAndroid(context, Widget title, List<ActionItem> actions,
      List<ActionItem> shortcutActions) {
    List<Widget> actionWidgets = List<Widget>();
    if (shortcutActions != null && shortcutActions.length > 0) {
      actionWidgets.add(shortcutActionButton(context, shortcutActions));
    }
    actionWidgets.addAll(actionItemToAndroidAction(actions));
    return adaptiveAppBar(context, title, actionWidgets,
        leading: this.showBackAction
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async => await navigateBackOrHomeAsync(context),
              )
            : null);
  }

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}

Widget appBarForSubPageHelper(context,
    {Widget title,
    List<ActionItem> actions,
    bool showHomeAction = false,
    bool showBackAction = true,
    List<ActionItem> shortcutActions}) {
  if (actions == null || actions.length == 0) {
    actions = List<ActionItem>();
  }
  if (showHomeAction) {
    actions.add(ActionItem(
        icon: Icons.home,
        onPressed: () async => await navigateHomeAsync(context)));
  }
  return AppBarForSubPage(
      title, actions, showHomeAction, showBackAction, shortcutActions);
}
