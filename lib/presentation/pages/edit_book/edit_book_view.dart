import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/presentation/pages/edit_book/edit_book_view_model.dart';
import 'package:quote_keeper/data/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class EditBookView extends StatelessWidget {
  EditBookView({Key? key}) : super(key: key);

  /// Key that holds the current state of the scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _quoteController = TextEditingController();

  final ModalService _modalService = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RxBool _formIsDirty = false.obs;

  void _exitPage(BuildContext context, BookModel book) async {
    // If the user altered info on this page.
    if (_formIsDirty.value == true) {
      var confirm = await _modalService.showConfirmation(
          context: context,
          title: 'Update Quote First?',
          message: 'Select "No" if you don\'t care about your changes.');

      if (confirm != null && confirm == false) {
        Get.back<BookModel>(result: book);
      }
    } else {
      Get.back<BookModel>(result: book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditBookViewModel>(
      init: EditBookViewModel(),
      builder: (model) {
        _quoteController.text = model.book.quote;

        return SimplePageWidget(
          scaffoldKey: _scaffoldKey,
          leftIconButton: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () async {
              _exitPage(context, model.book);
            },
          ),
          rightIconButton: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              bool? confirm = await _modalService.showConfirmation(
                context: context,
                title: 'Delete Quote',
                message: 'Are you sure?',
              );

              if (confirm == null || confirm == false) {
                return;
              }
              await model.deleteQuote();

              Get.back();
            },
          ),
          title: 'Edit Book',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: () => _formIsDirty.value = true,
              child: Column(
                children: [
                  Text(
                    model.book.title,
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
                            color:
                                Theme.of(context).textTheme.titleLarge!.color),
                        counterStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleLarge!.color),
                        hintText:
                            'Enter new favorite quote from ${model.book.title}',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: Text(model.isHidden ? 'Hidden' : 'Visible',
                        style: Theme.of(context).textTheme.headlineSmall),
                    subtitle: Text(
                        'Book ${model.isHidden ? 'cannot' : 'can'} be fetched by the "Get Random Quote" button on the dashboard.',
                        style: Theme.of(context).textTheme.bodyMedium),
                    value: !model.isHidden,
                    onChanged: (val) {
                      _formIsDirty.value = true;
                      model.toggleIsHidden(val);
                    },
                    secondary: Icon(
                        model.isHidden ? Icons.hide_image : Icons.image,
                        color: Theme.of(context).iconTheme.color),
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                  SwitchListTile(
                    title: Text(model.isComplete ? 'Complete' : 'Incomplete',
                        style: Theme.of(context).textTheme.headlineSmall),
                    subtitle: Text(
                        'You have ${model.isComplete ? '' : 'not '}finished reading this book.',
                        style: Theme.of(context).textTheme.bodyMedium),
                    value: model.isComplete,
                    onChanged: (val) {
                      _formIsDirty.value = true;
                      model.toggleIsComplete(val);
                    },
                    secondary: Icon(
                        model.isComplete ? Icons.check : Icons.cancel,
                        color: Theme.of(context).iconTheme.color),
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    child: const Text('Update Quote'),
                    onPressed: () async {
                      bool? confirm = await _modalService.showConfirmation(
                        context: context,
                        title: 'Update Quote',
                        message: 'Are you sure?',
                      );

                      if (confirm == null || confirm == false) {
                        return;
                      }

                      try {
                        await model.updateQuote(quote: _quoteController.text);

                        _formIsDirty.value = false;

                        _modalService.showInSnackBar(
                            context: context,
                            message: 'Your changes were saved.',
                            title: 'Updated');
                      } catch (e) {
                        _modalService.showInSnackBar(
                          context: context,
                          message: 'Error',
                          title: e.toString(),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
