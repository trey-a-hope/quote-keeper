import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/ui/quotes/quotes_view_model.dart';
import 'package:book_quotes/widgets/quote_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class QuotesView extends StatelessWidget {
  const QuotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuotesViewModel>(
      init: QuotesViewModel(),
      builder: (model) => SimplePageWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.load(),
          child: Icon(Icons.refresh),
        ),
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        rightIconButton: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            Get.toNamed(Globals.routeCreateQuote);
          },
        ),
        title: 'Quotes',
        child: ListView.builder(
          itemCount: model.quotes.length,
          itemBuilder: (_, index) => QuoteWidget(
            quote: model.quotes[index],
          ),
        ),
      ),
    );
  }
}
