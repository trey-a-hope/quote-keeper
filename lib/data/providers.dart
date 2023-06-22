import 'package:book_quotes/data/book_provider.dart';
import 'package:book_quotes/data/photo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers {
  static final ref = ProviderContainer();

  static final bookProvider = ChangeNotifierProvider(
    (_) => BookProvider(),
  );

  static final photoProvider =
      ChangeNotifierProvider.family<PhotoProvider, PhotoProviderTag>(
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
