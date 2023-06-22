import 'package:book_quotes/services/modal_service.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  final ModalService _modalService = ModalService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardViewModel>(
      init: DashboardViewModel(),
      builder: (model) => model.book == null
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
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 1],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      '"${model.book!.quote}"',
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium!.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton.extended(
                            icon: const Icon(Icons.refresh),
                            backgroundColor: Colors.blue,
                            onPressed: () => model.load(),
                            label: const Text('Fetch New Book'),
                          ),
                          SpeedDial(
                            animatedIcon: AnimatedIcons.menu_close,
                            animatedIconTheme: const IconThemeData(size: 28.0),
                            backgroundColor: Colors.green[900],
                            visible: true,
                            curve: Curves.bounceInOut,
                            children: [
                              SpeedDialChild(
                                child: const Icon(Icons.logout,
                                    color: Colors.white),
                                backgroundColor: Colors.red,
                                onTap: () async {
                                  bool? confirm =
                                      await _modalService.showConfirmation(
                                    context: context,
                                    title: 'Logout',
                                    message: 'Are you sure?',
                                  );

                                  if (confirm == null || confirm == false) {
                                    return;
                                  }

                                  FirebaseAuth.instance.signOut();
                                },
                                label: 'Logout',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Colors.red.shade800,
                              ),
                              SpeedDialChild(
                                child:
                                    const Icon(Icons.book, color: Colors.white),
                                backgroundColor: Colors.purple,
                                onTap: () => Get.toNamed(Globals.routeBooks),
                                label: 'All Books',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Colors.purple.shade800,
                              ),
                              SpeedDialChild(
                                child: const Icon(Icons.share,
                                    color: Colors.white),
                                backgroundColor: Colors.teal,
                                onTap: () => Share.share(
                                  model.book!.quote,
                                  subject:
                                      '${model.book!.title} by ${model.book!.author}',
                                ),
                                label: 'Share',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Colors.teal.shade800,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
