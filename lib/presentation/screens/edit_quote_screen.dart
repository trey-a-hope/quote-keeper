import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_util/modal_util.dart';
import 'package:quote_keeper/domain/models/book_model.dart';
import 'package:quote_keeper/presentation/widgets/app_bar_widget.dart';
import 'package:quote_keeper/presentation/widgets/qk_full_button.dart';
import 'package:quote_keeper/utils/config/providers.dart';

class EditQuoteScreen extends ConsumerStatefulWidget {
  const EditQuoteScreen(this.book, {super.key});

  final BookModel book;

  @override
  ConsumerState<EditQuoteScreen> createState() => _EditQuoteScreenState();
}

class _EditQuoteScreenState extends ConsumerState<EditQuoteScreen> {
  final _quoteController = TextEditingController();

  late bool _complete;
  late bool _hidden;

  @override
  void initState() {
    _quoteController.text = widget.book.quote;
    _complete = widget.book.complete;
    _hidden = widget.book.hidden;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget.appBar(
        title: 'Edit Quote',
        implyLeading: true,
        context: context,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              bool? confirm = await ModalUtil.showConfirmation(
                context,
                title: 'Delete Quote',
                message: 'Are you sure?',
              );

              if (confirm == null || confirm == false) {
                return;
              }

              if (!context.mounted) return;

              await ref.read(Providers.booksAsyncProvider.notifier).deleteBook(
                    id: widget.book.id!,
                    context: context,
                  );

              if (!context.mounted) return;

              context.pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                widget.book.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor:
                      Theme.of(context).textTheme.headlineMedium!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _quoteController,
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
                        'Enter new favorite quote from ${widget.book.title}',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SwitchListTile(
                title: Text(_hidden ? 'Hidden' : 'Visible',
                    style: Theme.of(context).textTheme.headlineSmall),
                subtitle: Text(
                    'Book ${_hidden ? 'cannot' : 'can'} be fetched by the "Get Random Quote" button on the dashboard.',
                    style: Theme.of(context).textTheme.bodyMedium),
                value: _hidden,
                onChanged: (val) => setState(() => _hidden = val),
                secondary: Icon(_hidden ? Icons.hide_image : Icons.image,
                    color: Theme.of(context).iconTheme.color),
                activeTrackColor: Colors.lightGreenAccent,
                activeThumbColor: Colors.green,
              ),
              SwitchListTile(
                title: Text(_complete ? 'Complete' : 'Incomplete',
                    style: Theme.of(context).textTheme.headlineSmall),
                subtitle: Text(
                    'You have ${_complete ? '' : 'not '}finished reading this book.',
                    style: Theme.of(context).textTheme.bodyMedium),
                value: _complete,
                onChanged: (val) => setState(() => _complete = val),
                secondary: Icon(_complete ? Icons.check : Icons.cancel,
                    color: Theme.of(context).iconTheme.color),
                activeTrackColor: Colors.lightGreenAccent,
                activeThumbColor: Colors.green,
              ),
              const Spacer(),
              QKFullButton(
                label: 'SAVE',
                onTap: () async {
                  bool? confirm = await ModalUtil.showConfirmation(
                    context,
                    title: 'Update Quote',
                    message: 'Are you sure?',
                  );

                  if (confirm == null || confirm == false) {
                    return;
                  }

                  try {
                    ref.read(Providers.booksAsyncProvider.notifier).updateBook(
                      id: widget.book.id!,
                      data: {
                        'quote': _quoteController.text,
                        'hidden': _hidden,
                        'complete': _complete,
                      },
                    );

                    if (!context.mounted) return;

                    ModalUtil.showSuccess(
                      context,
                      title: 'Your changes were saved.',
                    );
                  } catch (e) {
                    if (!context.mounted) return;

                    ModalUtil.showError(
                      context,
                      title: e.toString(),
                    );
                  }
                },
                iconData: Icons.check,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
