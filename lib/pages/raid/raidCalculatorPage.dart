import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/adaptive/listWithScrollbar.dart';
import '../../components/scaffoldTemplates/genericPageScaffold.dart';
import '../../helpers/columnHelper.dart';
import '../../helpers/deviceHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/raid/raidViewModel.dart';
import 'raidCalculatorPage.desktop.dart';
import 'raidCalculatorPage.mobile.dart';
import 'raidCalculatorResultComponent.dart';

const greenyDevGithubImage =
    'https://avatars0.githubusercontent.com/u/3734204?s=460&u=7eb6ec6aa9200855109647c7fcdd159069b673fe&v=4';
const greenyDevGithubLink = 'https://github.com/greeny/?ref=AssistantSMS';
const greenyDevTool = 'https://scrapmechanic.greeny.dev/?ref=AssistantSMS';

class RaidCalcPage extends StatefulWidget {
  const RaidCalcPage({Key key}) : super(key: key);

  @override
  _RaidCalcWidget createState() => _RaidCalcWidget();
}

// https://scrapmechanic.greeny.dev/
class _RaidCalcWidget extends State<RaidCalcPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RaidViewModel>(
      converter: (store) => RaidViewModel.fromStore(store),
      builder: (_, viewModel) => _RaidCalcInnerWidget(
          viewModel, RaidCalcDesktopInputScreen(viewModel)),
    );
  }
}

class _RaidCalcInnerWidget extends StatelessWidget {
  final Widget desktopInputScreen;
  final RaidViewModel viewModel;
  _RaidCalcInnerWidget(this.viewModel, this.desktopInputScreen);

  @override
  Widget build(BuildContext context) {
    return genericPageScaffold(
      context,
      Translations.get(context, LocaleKey.raidCalculator),
      null,
      body: (BuildContext innerContext, _) => BreakpointBuilder(
        builder: (BuildContext innerContext, Breakpoint breakpoint) {
          var showMobileView = isMobileScreenWidth(breakpoint);
          return getBody(innerContext, viewModel, showMobileView);
        },
      ),
      showShortcutLinks: true,
    );
  }

  Widget getBody(
      BuildContext context, RaidViewModel viewModel, bool showMobileView) {
    List<Widget> columnWidgets = List<Widget>();

    if (showMobileView) {
      columnWidgets.add(RaidCalcMobileInputScreen(viewModel));
      columnWidgets.add(customDivider());
    } else {
      columnWidgets.add(desktopInputScreen);
    }
    columnWidgets.add(RaidCalculatorResultComponent(viewModel, showMobileView));

    return listWithScrollbar(
        itemCount: columnWidgets.length,
        itemBuilder: (context, index) => columnWidgets[index]);
  }
}
