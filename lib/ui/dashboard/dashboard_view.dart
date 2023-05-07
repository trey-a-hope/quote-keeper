import 'package:book_quotes/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

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
                            label: const Text('Books'),
                            icon: const Icon(Icons.book),
                            heroTag: 'books',
                            backgroundColor: Colors.red,
                            onPressed: () => Get.toNamed(Globals.routeBooks),
                          ),
                          FloatingActionButton.extended(
                            label: const Text('Share'),
                            icon: const Icon(Icons.share),
                            heroTag: 'share',
                            backgroundColor: Colors.blue,
                            onPressed: () => Share.share(
                              model.book!.quote,
                              subject:
                                  '${model.book!.title} by ${model.book!.author}',
                            ),
                          ),
                          FloatingActionButton.extended(
                            label: const Text('Reload'),
                            icon: const Icon(Icons.refresh),
                            heroTag: 'refresh',
                            backgroundColor: Colors.green,
                            onPressed: () => model.load(),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
    );
  }
}
