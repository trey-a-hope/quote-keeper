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
            onPressed: () {
              Get.back(result: false);
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

              Navigator.of(context).pop();
            },
          ),
          title: 'Edit Book',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  model.book.title,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).textTheme.headline4!.color,
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
                          color: Theme.of(context).textTheme.headline6!.color),
                      counterStyle: TextStyle(
                          color: Theme.of(context).textTheme.headline6!.color),
                      hintText:
                          'Enter new favorite quote from ${model.book.title}',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SwitchListTile(
                  title: Text(model.isHidden ? 'Hidden' : 'Visible'),
                  value: model.isHidden,
                  onChanged: model.toggleIsHidden,
                  secondary:
                      Icon(model.isHidden ? Icons.hide_image : Icons.image),
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                SwitchListTile(
                  title: Text(model.isComplete ? 'Complete' : 'Incomplete'),
                  value: model.isComplete,
                  onChanged: model.toggleIsComplete,
                  secondary:
                      Icon(model.isComplete ? Icons.check : Icons.cancel),
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

                    await model.updateQuote(quote: _quoteController.text);

                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
