import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/domain/providers/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class CreateQuoteScreen extends ConsumerWidget {
  CreateQuoteScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _quoteController = TextEditingController();

  final ModalService _modalService = Get.find();

  final TutorialService _tutorialService = Get.find();

  final SearchBooksResultModel book = Get.arguments['book'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookProvider = ref.watch(Providers.bookProvider);

    _tutorialService.showCreateQuoteTutorial(context);

    return SimplePageWidget(
      scaffoldKey: _scaffoldKey,
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Get.back(result: false);
        },
      ),
      rightIconButton: IconButton(
        icon: Icon(key: _tutorialService.createQuoteTarget1, Icons.check),
        onPressed: () async {
          bool? confirm = await _modalService.showConfirmation(
            context: context,
            title: 'Submit Quote for ${book.title}',
            message: 'Are you sure?',
          );

          if (confirm == null || confirm == false) {
            return;
          }

          try {
            await bookProvider.createBook(
              title: book.title,
              author: book.author,
              quote: _quoteController.text,
              imgUrl: book.imgUrl,
            );

            // Return to dashboard by removing two screens.
            Get.back();
            Get.back();

            _tutorialService.showRefreshDashboardTutorial(context);
          } catch (error) {
            Get.showSnackbar(
              GetSnackBar(
                title: 'Error',
                message: error.toString(),
                backgroundColor: Colors.red,
                icon: const Icon(Icons.error),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
      ),
      title: 'Create Quote',
      child: bookProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: AnimateList(
                  interval: 400.ms,
                  effects: Globals.fadeEffect,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor:
                            Theme.of(context).textTheme.headline4!.color,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _quoteController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.headline3!.color,
                        ),
                        maxLines: 10,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6!.color),
                          counterStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline6!.color),
                          hintText:
                              'Enter your favorite quote from ${book.title}...',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
