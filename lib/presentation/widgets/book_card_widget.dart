import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatefulWidget {
  const BookWidget({Key? key, required this.book}) : super(key: key);

  final BookModel book;

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  late BookModel _book;

  @override
  void initState() {
    super.initState();

    _book = widget.book;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        height: 210,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 130,
              child: CachedNetworkImage(
                imageUrl: _book.imgPath != null
                    ? _book.imgPath!
                    : Globals.libraryBackground,
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
                      _book.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    Text(
                      '"${_book.quote}"',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Divider(),
                    Row(
                      children: [
                        if (_book.hidden) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.hide_image,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                        ],
                        if (_book.complete) ...[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          )
                        ],
                        const Spacer(),
                        Text(
                          _book.author,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        Consumer(
                          builder: (context, ref, child) {
                            return ElevatedButton(
                              onPressed: () async {
                                context.goNamed(
                                  Globals.routeEditQuote,
                                  pathParameters: <String, String>{
                                    // Note: Conversion between String and Timestamp since Timestamp can't be encodded.
                                    'book': jsonEncode(
                                      {
                                        'id': _book.id,
                                        'title': _book.title,
                                        'author': _book.author,
                                        'quote': _book.quote,
                                        'imgPath': _book.imgPath,
                                        'hidden': _book.hidden,
                                        'complete': _book.complete,
                                        'created':
                                            _book.created.toIso8601String(),
                                        'modified':
                                            _book.modified.toIso8601String(),
                                        'uid': _book.uid,
                                      },
                                    )
                                  },
                                );
                              },
                              child: const Text('Edit'),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
