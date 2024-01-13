import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_keeper/data/services/tutorial_service.dart';
import 'package:quote_keeper/domain/models/search_book_result/search_books_result_model.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/presentation/widgets/qk_scaffold_widget.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateQuoteScreen extends ConsumerWidget {
  CreateQuoteScreen({
    Key? key,
    required this.searchBooksResult,
  }) : super(key: key);

  final SearchBooksResultModel searchBooksResult;

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

    return QKScaffoldWidget(
      scaffoldKey: _scaffoldKey,
      leftIconButton: IconButton(
        icon: const Icon(Icons.chevron_left),
        onPressed: () => context.pop(),
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
                      createBookNotifier.updateBook(
                        book.copyWith(
                          quote: val,
                        ),
                      );
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
                        'Enter your favorite quote from ${searchBooksResult.title}...',
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
                          await createBookNotifier
                              .createBook(searchBooksResult);

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

                          if (!context.mounted) return;

                          // Return to dashboard.
                          context.pop();
                          context.pop();
                        } catch (error) {
                          if (!context.mounted) return;

                          _modalService.showInSnackBar(
                              context: context,
                              icon: const Icon(Icons.cancel),
                              message: error.toString(),
                              title: 'Error');
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
