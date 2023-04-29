import 'package:book_quotes/constants/globals.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () => Get.toNamed(
          Globals.routeEditQuote,
          arguments: {
            'quote': quote,
          },
        ),
        child: Container(
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
      ),
    );
  }
}
