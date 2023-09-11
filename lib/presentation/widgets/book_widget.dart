import 'package:book_quotes/domain/models/books/book_model.dart';
import 'package:book_quotes/utils/constants/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.book,
    required this.hideBook,
    required this.showBook,
    required this.shareBook,
    required this.deleteBook,
    this.onTap,
  });

  final BookModel book;
  final void Function(BuildContext) hideBook;
  final void Function(BuildContext) showBook;
  final void Function(BuildContext) shareBook;
  final void Function(BuildContext) deleteBook;
  final void Function()? onTap;

  static const List<Color> _colors = [
    Color(0xFFFE4A49),
    Color(0xFF21B7CA),
    Color(0xFF7BC043),
    Color(0xFF0392CF),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              // If the book is hidden, display the 'Show' panel.
              if (book.hidden) ...[
                SlidableAction(
                  onPressed: showBook,
                  backgroundColor: _colors[1],
                  foregroundColor: Colors.white,
                  icon: Icons.present_to_all,
                  label: 'Show',
                ),
              ],
              // If the book is not hidden, display the 'Hide' panel.
              if (!book.hidden) ...[
                SlidableAction(
                  onPressed: hideBook,
                  backgroundColor: _colors[2],
                  foregroundColor: Colors.white,
                  icon: Icons.hide_image,
                  label: 'Hide',
                ),
              ],

              SlidableAction(
                onPressed: shareBook,
                backgroundColor: _colors[0],
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => Get.toNamed(
                  Globals.routeEditQuote,
                  arguments: {
                    'book': book,
                  },
                ),
                backgroundColor: _colors[3],
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: deleteBook,
                backgroundColor: _colors[0],
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: _BookWidgetView(
            book: book,
          ),
        ),
      ),
    );
  }
  // .slide();
}

class _BookWidgetView extends StatelessWidget {
  const _BookWidgetView({
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        height: 200,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 130,
              child: CachedNetworkImage(
                imageUrl: book.imgPath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
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
                      book.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Divider(),
                    Text(
                      '"${book.quote}"',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      softWrap: false,
                      style: context.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          book.author,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        if (book.hidden) ...[
                          const Spacer(),
                          const Icon(
                            Icons.hide_image,
                            color: Colors.green,
                            size: 15,
                          )
                        ]
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
