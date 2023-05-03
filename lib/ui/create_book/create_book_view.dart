import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/services/model_service.dart';
import 'package:book_quotes/ui/create_book/create_book_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class CreateBookView extends StatelessWidget {
  CreateBookView({Key? key}) : super(key: key);

  /// Key that holds the current state of the scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _bookTitleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  final ModalService _modalService = ModalService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateBookViewModel>(
      init: CreateBookViewModel(),
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
              await model.create(
                title: _bookTitleController.text,
                author: _authorController.text,
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
        title: 'Create Quote',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (value) => {model.update()},
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).textTheme.headline4!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _bookTitleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    counterStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    hintText: 'Enter book title.',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (value) => {model.update()},
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).textTheme.headline4!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _authorController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    counterStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    hintText: 'Enter book author.',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
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
                        'Enter your favorite quote from ${_bookTitleController.text}',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => model.updateImage(
                  bookTitle: _bookTitleController.text,
                  imageSource: ImageSource.gallery,
                ),
                child: SizedBox(
                  height: 200,
                  width: 130,
                  child: CachedNetworkImage(
                    imageUrl: model.imgPath ?? Globals.dummyProfilePhotoUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
