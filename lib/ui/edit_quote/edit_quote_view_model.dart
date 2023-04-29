import 'package:book_quotes/models/quote_model.dart';
import 'package:book_quotes/services/quote_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditQuoteViewModel extends GetxController {
  EditQuoteViewModel();

  final QuoteService _quoteService = QuoteService();

  final QuoteModel quoteModel = Get.arguments['quote'];

  @override
  void onInit() async {
    super.onInit();

    update();
  }

  Future updateQuote({
    required String quote,
  }) async {
    try {
      await _quoteService.updateQuote(
        id: quoteModel.id!,
        data: {
          'quote': quote,
        },
      );
    } catch (error) {
      debugPrint(error.toString());
      throw Exception(error);
    }
  }
}
