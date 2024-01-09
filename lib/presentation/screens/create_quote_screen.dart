import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/presentation/widgets/quoter_keeper_scaffold.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class CreateQuoteScreen extends ConsumerWidget {
  CreateQuoteScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _modalService = ModalService();
  final _tutorialService = TutorialService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createBookNotifierProvider = Providers.createBookNotifierProvider;
    final book = ref.watch(createBookNotifierProvider);
    final createBookNotifier = ref.read(createBookNotifierProvider.notifier);

    final shouldDisplayTutorial =
        ref.read(Providers.shouldDisplayTutorialStateNotifierProvider);

    if (shouldDisplayTutorial) {
      _tutorialService.showCreateQuoteTutorial(context);
    }

    return QuoteKeeperScaffold(
      scaffoldKey: _scaffoldKey,
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: 'Create Quote',
      child: Padding(
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
                    if (book != null) {
                      debugPrint(book.toString());
                      debugPrint(val);
                      var newBook = book.copyWith(quote: val);
                      createBookNotifier.updateBook(newBook);
                    }
                  },
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor:
                      Theme.of(context).textTheme.headlineMedium!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.displaySmall!.color,
                  ),
                  maxLines: 10,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color),
                    counterStyle: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge!.color),
                    hintText:
                        'Enter your favorite quote from ${book?.title}...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                key: _tutorialService.createQuoteTarget,
                onPressed: book == null || book.quote.isEmpty
                    ? null
                    : () async {
                        // Prompt user for submitting quote.
                        bool? confirm = await _modalService.showConfirmation(
                          context: context,
                          title: 'Submit Quote for ${book.title}',
                          message: 'Are you sure?',
                        );

                        if (confirm == null || confirm == false) {
                          return;
                        }

                        try {
                          // Submit the quote.
                          createBookNotifier.createBook();
                          // await bookProvider.createBook(
                          //   title: book.title,
                          //   author: book.author,
                          //   imgUrl: book.imgUrl,
                          // );

                          // Increment total book count.
                          ref
                              .read(Providers
                                  .totalBooksCountStateNotifierProvider
                                  .notifier)
                              .increment();

                          // Turn off tutorial flag.
                          ref
                              .read(Providers
                                  .shouldDisplayTutorialStateNotifierProvider
                                  .notifier)
                              .markTutorialComplete();

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
      ),
    );
  }
}
