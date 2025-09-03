import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_util/modal_util.dart';
import 'package:quote_keeper/domain/models/search_books_result_model.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/qk_full_button.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateQuoteScreen extends ConsumerWidget {
  const CreateQuoteScreen({
    super.key,
    required this.searchBooksResult,
  });

  final SearchBooksResultModel searchBooksResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createBookProvider = Providers.createBookProvider;
    final book = ref.watch(createBookProvider);
    final createBookNotifier = ref.read(createBookProvider.notifier);

    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Create Quote',
        implyLeading: true,
        context: context,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: AnimateList(
              interval: 400.ms,
              effects: Globals.effects.fade,
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
                QKFullButton(
                  iconData: Icons.check,
                  label: 'SAVE',
                  onTap: () async {
                    if (book == null) throw Exception('Book is null');

                    if (book.quote.isEmpty) {
                      ModalUtil.showError(
                        context,
                        title: 'Quote cannot be empty.',
                      );

                      return;
                    }

                    // Prompt user for submitting quote.
                    bool? confirm = await ModalUtil.showConfirmation(
                      context,
                      title: 'Submit Quote for ${book.title}',
                      message: 'Are you sure?',
                    );

                    if (confirm == null || confirm == false) {
                      return;
                    }

                    try {
                      // Submit the quote.
                      await createBookNotifier.createBook(searchBooksResult);

                      if (!context.mounted) return;

                      // Return to dashboard.
                      context.pop();
                      context.pop();
                    } catch (error) {
                      if (!context.mounted) return;

                      ModalUtil.showError(
                        context,
                        title: error.toString(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
