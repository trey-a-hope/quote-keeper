import 'package:book_quotes/ui/drawer/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';
import 'dashboard_view_model.dart';

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
          onPressed: () {
            model.load();
          },
        ),
        title: 'QOTD',
        child: model.book == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.network(model.book!.imgPath).image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    // color: colorGrey,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0, 1],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '"${model.book!.quote}"',
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
