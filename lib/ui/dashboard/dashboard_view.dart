import 'package:book_quotes/ui/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';
import 'dashboard_view_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardViewModel>(
      init: DashboardViewModel(),
      builder: (model) => SimplePageWidget(
        key: const Key('simple-page-widget-key'),
        drawer: DrawerView(
          key: const Key('drawer-view-key'),
        ),
        scaffoldKey: _scaffoldKey,
        leftIconButton: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        rightIconButton: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            // await model.refreshPage();
          },
        ),
        title: 'QOTD',
        child: ListView(
          children: [Text('f')],
        ),
      ),
    );
  }
}
