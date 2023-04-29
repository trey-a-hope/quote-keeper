import 'package:book_quotes/models/quote_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key, required this.quote});

  final QuoteModel quote;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          height: 200,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 130,
                child: CachedNetworkImage(
                  imageUrl: quote.imgPath,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    color: Theme.of(context).canvasColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        quote.bookTitle,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Divider(),
                      Text(
                        '"${quote.quote}"',
                        style: context.textTheme.headline6,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            quote.author,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat('MMM dd, yyyy').format(quote.createdAt),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   child: Row(
        //     children: [
        //       Text(
        //         critique.created.isAfter(
        //                 DateTime.now().toUtc().subtract(Duration(days: 6)))
        //             ? 'Posted ${_timeAgoService.timeAgoSinceDate(dateTime: critique.created)}'
        //             : 'Posted ${DateFormat('MMM dd, yyyy').format(critique.created.toLocal())}',
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Spacer(),
        //       LikeButton(
        //         size: 25,
        //         isLiked: model.isLiked,
        //         circleColor: CircleColor(
        //             start: Color(0xff00ddff), end: Color(0xff0099cc)),
        //         bubblesColor: BubblesColor(
        //           dotPrimaryColor: Color(0xff33b5e5),
        //           dotSecondaryColor: Color(0xff0099cc),
        //         ),
        //         likeBuilder: (bool isLiked) {
        //           return Icon(
        //             Icons.favorite,
        //             color: isLiked ? Colors.red : Colors.grey,
        //             size: 25,
        //           );
        //         },
        //         likeCount: model.critique.likes.length,
        //         countBuilder: (int? count, bool isLiked, String text) {
        //           return Text(text);
        //         },
        //         onTap: (bool isLiked) async {
        //           if (_debounce?.isActive ?? false) _debounce!.cancel();
        //           _debounce = Timer(const Duration(milliseconds: 250), () {
        //             try {
        //               isLiked ? model.unlikeCritique() : model.likeCritique();
        //             } catch (e) {}
        //           });
        //           return !isLiked;
        //         },
        //       ),
        //       IconButton(
        //         onPressed: () {
        //           Get.defaultDialog(
        //             title: 'Critique For ${model.movie.title}',
        //             middleText: 'What would you like to do?',
        //             titleStyle: context.theme.textTheme.headline4,
        //             middleTextStyle: context.theme.textTheme.headline5,
        //             actions: [
        //               model.postedByMe
        //                   ? ElevatedButton(
        //                       onPressed: () async {
        //                         Get.back();

        //                         // Ask user if they want to delete critique.
        //                         final bool? confirm =
        //                             await _modalService.showConfirmation(
        //                                 context: context,
        //                                 title: 'Delete Critique',
        //                                 message: 'Are you sure?');

        //                         // Return if not true.
        //                         if (confirm == null || !confirm) return;

        //                         // Proceed to delete critique.
        //                         bool success = await model.deleteCritique();

        //                         // Show success or error message based on response.
        //                         if (success) {
        //                           Get.snackbar(
        //                             'Success',
        //                             'Your critique has been deleted.',
        //                             icon: Icon(
        //                               Icons.check,
        //                               color: Colors.white,
        //                             ),
        //                             snackPosition: SnackPosition.BOTTOM,
        //                             backgroundColor: Colors.green,
        //                             colorText: Colors.white,
        //                           );
        //                         } else {
        //                           Get.snackbar(
        //                             'Error',
        //                             'There was an issue deleting your critique.',
        //                             icon: Icon(
        //                               Icons.cancel,
        //                               color: Colors.white,
        //                             ),
        //                             snackPosition: SnackPosition.BOTTOM,
        //                             backgroundColor: Colors.red,
        //                             colorText: Colors.white,
        //                           );
        //                         }
        //                       },
        //                       child: Text('Delete'),
        //                     )
        //                   : ElevatedButton(
        //                       onPressed: () async {
        //                         Get.back();

        //                         // Ask user if they want to delete critique.
        //                         final bool? confirm =
        //                             await _modalService.showConfirmation(
        //                           context: context,
        //                           title: 'Report Critique',
        //                           message:
        //                               'Is the content of this critique grotesque, vulgar, or inappropriate in any way?',
        //                         );

        //                         // Return if not true.
        //                         if (confirm == null || !confirm) return;

        //                         // Proceed to delete critique.
        //                         bool success = await model.deleteCritique();

        //                         // Show success or error message based on response.
        //                         if (success) {
        //                           Get.snackbar(
        //                             'Success',
        //                             'The critique has been flagged as inappropriate.',
        //                             icon: Icon(
        //                               Icons.check,
        //                               color: Colors.white,
        //                             ),
        //                             snackPosition: SnackPosition.BOTTOM,
        //                             backgroundColor: Colors.green,
        //                             colorText: Colors.white,
        //                           );
        //                         } else {
        //                           Get.snackbar(
        //                             'Error',
        //                             'There was an issue flagged this critique as inappropriate.',
        //                             icon: Icon(
        //                               Icons.cancel,
        //                               color: Colors.white,
        //                             ),
        //                             snackPosition: SnackPosition.BOTTOM,
        //                             backgroundColor: Colors.red,
        //                             colorText: Colors.white,
        //                           );
        //                         }
        //                       },
        //                       child: Text('Report'),
        //                     ),
        //               ElevatedButton(
        //                 onPressed: () async {
        //                   Get.back();

        //                   List<String> likeUids = model.critique.likes;

        //                   Get.toNamed(
        //                     Globals.ROUTES_USERS_LIST,
        //                     arguments: {'uids': likeUids, 'title': 'Likes'},
        //                   );
        //                 },
        //                 child: Text('View Likes'),
        //               )
        //             ],
        //             barrierDismissible: true,
        //             radius: 10,
        //             // ),
        //           );
        //         },
        //         icon: Icon(
        //           MdiIcons.dotsVertical,
        //           color: Colors.grey,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Divider(),
      ],
    );
  }
}
