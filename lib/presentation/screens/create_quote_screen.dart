import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/domain/providers/providers.dart';
import 'package:quote_keeper/domain/providers/total_books_count_state_notifier_provider.dart';
import 'package:quote_keeper/presentation/widgets/quoter_keeper_scaffold.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class CreateQuoteScreen extends ConsumerWidget {
  CreateQuoteScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ModalService _modalService = Get.find();

  final TutorialService _tutorialService = Get.find();

  final SearchBooksResultModel book = Get.arguments['book'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookProvider = ref.watch(Providers.bookProvider);

    return QuoteKeeperScaffold(
      scaffoldKey: _scaffoldKey,
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () {
          Get.back(result: false);
        },
      ),
      title: 'Create Quote',
      child: bookProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Builder(builder: (context) {
              if (bookProvider.showTutorial) {
                _tutorialService.showCreateQuoteTutorial(context);
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: AnimateList(
                    interval: 400.ms,
                    effects: Globals.fadeEffect,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          onChanged: (val) {
                            bookProvider.updateQuote(val);
                          },
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor:
                              Theme.of(context).textTheme.headlineMedium!.color,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.displaySmall!.color,
                          ),
                          maxLines: 10,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color),
                            counterStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color),
                            hintText:
                                'Enter your favorite quote from ${book.title}...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        key: _tutorialService.createQuoteTarget,
                        onPressed: bookProvider.quote.isEmpty
                            ? null
                            : () async {
                                // Prompt user for submitting quote.
                                bool? confirm =
                                    await _modalService.showConfirmation(
                                  context: context,
                                  title: 'Submit Quote for ${book.title}',
                                  message: 'Are you sure?',
                                );

                                if (confirm == null || confirm == false) {
                                  return;
                                }

                                try {
                                  // Submit the quote.
                                  await bookProvider.createBook(
                                    title: book.title,
                                    author: book.author,
                                    imgUrl: book.imgUrl,
                                  );

                                  // Increment total book count.
                                  ref
                                      .read(totalBooksCountStateNotifierProvider
                                          .notifier)
                                      .increment();

                                  // Return to dashboard.
                                  Get.back();
                                  Get.back();
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
                        child: const Text('Submit Quote'),
                      ),
                    ],
                  ),
                ),
              );
            }),
    );
  }
}
