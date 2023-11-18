import 'package:quote_keeper/domain/providers/book_provider.dart';
import 'package:quote_keeper/domain/providers/photo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final ref = ProviderContainer();

  static final bookProvider = ChangeNotifierProvider.autoDispose(
    (_) => BookProvider(),
  );

  static final photoProvider = ChangeNotifierProvider.autoDispose
      .family<PhotoProvider, PhotoProviderTag>(
    (ref, tag) {
      switch (tag) {
        case PhotoProviderTag.createBook:
          return PhotoProvider();
        case PhotoProviderTag.editProfile:
          return PhotoProvider();
        default:
          throw Exception();
      }
    },
  );
}

enum PhotoProviderTag {
  createBook('create_book'),
  editProfile('edit_profile');

  final String title;

  const PhotoProviderTag(this.title);
}
