import 'package:booksapp/hive_models/books.dart';

import '../models/book_model.dart';

class FetchHomeRepo {
  Future<Map<String, dynamic>> getHomePageBooks() async {
    BookModelList booksData;

    final books = Books.getBooks();
    print(books.length);
    if (books.length != 0) {
      booksData = BookModelList.fromBox(books);
      return {
        "tranding": booksData.books.sublist(0, 4),
        "topRated": booksData.books.sublist(4),
      };
    } else {
      throw Exception('Failed to load data');
    }
  }
}
