import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

class QuoteCardWidget extends StatelessWidget {
  const QuoteCardWidget({
    Key? key,
    required this.book,
    this.onTap,
  }) : super(key: key);

  final BookModel book;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: FittedBox(
          child: SizedBox(
            height: size.height * 0.23,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.67,
                  padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(15),
                    ),
                    color: Theme.of(context).primaryColorDark,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.author,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      Text(book.title,
                          style: Theme.of(context).textTheme.displaySmall!),
                      const Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "\"${book.quote}\"",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                          const Gap(10)
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          if (book.hidden) ...[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).canvasColor,
                              ),
                              child: Icon(
                                size: 15,
                                Icons.hide_image,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            const Gap(10),
                          ],
                          if (book.complete) ...[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).canvasColor,
                              ),
                              child: Icon(
                                size: 15,
                                Icons.check,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 130,
                  child: CachedNetworkImage(
                    imageUrl: book.imgPath != null
                        ? book.imgPath!
                        : Globals.networkImages.libraryBackground,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NullQuoteCardWidget extends StatelessWidget {
  const NullQuoteCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: FittedBox(
        child: SizedBox(
          height: size.height * 0.23,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.67,
                padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You don\'t have any books yet...',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                    Text('Go to the Quotes tab to add some!',
                        style: Theme.of(context).textTheme.displayMedium!),
                    const Gap(10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Check back here later.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        const Gap(10)
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(
                width: 130,
                child: CachedNetworkImage(
                  imageUrl: Globals.networkImages.libraryBackground,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
