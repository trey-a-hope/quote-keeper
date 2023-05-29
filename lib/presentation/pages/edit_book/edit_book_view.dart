import 'package:book_quotes/presentation/pages/edit_book/edit_book_view_model.dart';
import 'package:book_quotes/services/modal_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      builder: (model) => SimplePageWidget(
        scaffoldKey: _scaffoldKey,
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        rightIconButton: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () async {
            bool? confirm = await _modalService.showConfirmation(
              context: context,
              title: 'Submit Quote',
              message: 'Are you sure?',
            );

            if (confirm == null || confirm == false) {
              return;
            }

            try {
              await model.updateQuote(
                quote: _quoteController.text,
              );
              Get.back(result: true);
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
        title: 'Edit Book',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
              CachedNetworkImage(
                imageUrl: model.book.imgPath,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 30,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
