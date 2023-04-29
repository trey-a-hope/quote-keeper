import 'package:book_quotes/models/quote_model.dart';
import 'package:book_quotes/services/quote_service.dart';
import 'package:get/get.dart';

class QuotesViewModel extends GetxController {
  final QuoteService _quoteService = QuoteService();

  List<QuoteModel> quotes = [];

  @override
  void onInit() async {
    update();

    load();
    super.onInit();
  }

  void load() async {
    try {
      quotes = await _quoteService.retrieveQuotes();
      update();
    } catch (error) {
      throw Exception();
    }
  }
}
