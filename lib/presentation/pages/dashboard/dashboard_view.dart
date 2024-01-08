// import 'package:quote_keeper/data/services/share_service.dart';
// import 'package:quote_keeper/data/services/tutorial_service.dart';
// import 'package:quote_keeper/domain/models/books/book_model.dart';
// import 'package:quote_keeper/utils/constants/globals.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:get/get.dart';
// import 'dashboard_view_model.dart';

// class DashboardView extends StatelessWidget {
//   DashboardView({Key? key}) : super(key: key);

//   static const TextStyle labelStyle = TextStyle(
//     fontWeight: FontWeight.w500,
//     color: Colors.white,
//   );

//   final ShareService _shareService = Get.find();
//   final TutorialService _tutorialService = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     // Prompt user for potential updated version of app.
//     Globals.newVersionPlus.showAlertIfNecessary(context: context);

//     return GetBuilder<DashboardViewModel>(
//       init: DashboardViewModel(),
//       builder: (model) {
//         return model.isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Builder(
//                 builder: (context) {
//                   // if (model.showTutorial) {
//                   //   _tutorialService.showDashboardTutorial(context);
//                   // }

//                   return Stack(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: model.book?.imgPath != null
//                                 ? Image.network(model.book!.imgPath!).image
//                                 : Image.network(Globals.libraryBackground)
//                                     .image,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.black.withOpacity(0.8),
//                               Colors.black.withOpacity(0.8)
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             stops: const [0, 1],
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(32.0),
//                           child: Text(
//                             model.book?.quote != null
//                                 ? '"${model.book!.quote}"'
//                                 : 'No quotes yet...',
//                             textAlign: TextAlign.center,
//                             style: context.textTheme.displayMedium!.copyWith(
//                               color: Colors.white,
//                               letterSpacing: 1.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Column(
//                         children: [
//                           const Spacer(),
//                           Padding(
//                             padding: const EdgeInsets.all(32.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 if (model.book != null) ...[
//                                   FloatingActionButton.extended(
//                                     icon: const Icon(Icons.refresh),
//                                     backgroundColor: Theme.of(context)
//                                         .floatingActionButtonTheme
//                                         .backgroundColor,
//                                     onPressed: () => model.load(),
//                                     label: Text(
//                                       'Get Random Quote',
//                                       style: TextStyle(
//                                         color: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .foregroundColor,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                                 const Spacer(),
//                                 SpeedDial(
//                                   key: _tutorialService.dashboardTarget,
//                                   animatedIcon: AnimatedIcons.menu_close,
//                                   animatedIconTheme:
//                                       const IconThemeData(size: 28.0),
//                                   backgroundColor: Theme.of(context)
//                                       .floatingActionButtonTheme
//                                       .backgroundColor,
//                                   foregroundColor: Theme.of(context)
//                                       .floatingActionButtonTheme
//                                       .foregroundColor,
//                                   visible: true,
//                                   curve: Curves.bounceInOut,
//                                   children: [
//                                     SpeedDialChild(
//                                       child: const Icon(Icons.settings,
//                                           color: Colors.white),
//                                       backgroundColor: Theme.of(context)
//                                           .floatingActionButtonTheme
//                                           .backgroundColor,
//                                       foregroundColor: Theme.of(context)
//                                           .floatingActionButtonTheme
//                                           .foregroundColor,
//                                       onTap: () =>
//                                           Get.toNamed(Globals.routeSettings),
//                                       label: 'Settings',
//                                       labelStyle: labelStyle,
//                                       labelBackgroundColor: Theme.of(context)
//                                           .floatingActionButtonTheme
//                                           .backgroundColor,
//                                     ),
//                                     if (model.book != null) ...[
//                                       SpeedDialChild(
//                                         child: const Icon(Icons.book,
//                                             color: Colors.white),
//                                         backgroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .backgroundColor,
//                                         foregroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .foregroundColor,
//                                         onTap: () async {
//                                           var res = await Get.toNamed(
//                                               Globals.routeBooks);

//                                           if (res is BookModel) {
//                                             model.updateBook(newBook: res);
//                                           }
//                                         },
//                                         label: 'View All Quotes',
//                                         labelStyle: labelStyle,
//                                         labelBackgroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .backgroundColor,
//                                       ),
//                                     ],
//                                     if (model.book == null) ...[
//                                       SpeedDialChild(
//                                         child: const Icon(Icons.refresh,
//                                             color: Colors.white),
//                                         backgroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .backgroundColor,
//                                         foregroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .foregroundColor,
//                                         onTap: () => model.reload(),
//                                         label: 'Refresh',
//                                         labelStyle: labelStyle,
//                                         labelBackgroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .backgroundColor,
//                                       ),
//                                     ],
//                                     SpeedDialChild(
//                                       child: const Icon(Icons.add,
//                                           color: Colors.white),
//                                       backgroundColor: Theme.of(context)
//                                           .floatingActionButtonTheme
//                                           .backgroundColor,
//                                       foregroundColor: Theme.of(context)
//                                           .floatingActionButtonTheme
//                                           .foregroundColor,
//                                       onTap: () =>
//                                           Get.toNamed(Globals.routeSearchBooks),
//                                       label: 'Add New Quote',
//                                       labelStyle: labelStyle,
//                                       labelBackgroundColor: Theme.of(context)
//                                           .floatingActionButtonTheme
//                                           .backgroundColor,
//                                     ),
//                                     if (model.book != null) ...[
//                                       SpeedDialChild(
//                                         child: const Icon(Icons.share,
//                                             color: Colors.white),
//                                         backgroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .backgroundColor,
//                                         foregroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .foregroundColor,
//                                         onTap: () => _shareService.share(
//                                             book: model.book!),
//                                         label: 'Share This Quote',
//                                         labelStyle: labelStyle,
//                                         labelBackgroundColor: Theme.of(context)
//                                             .floatingActionButtonTheme
//                                             .backgroundColor,
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   );
//                 },
//               );
//       },
//     );
//   }
// }
