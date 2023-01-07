import 'package:booksapp/hive_models/books.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/error_model.dart';
import '../models/book_model.dart';

class FetchBookDataById {
  Future<List<dynamic>> getDetails(String id) async {
    BookModel? bookData;
    BookModelList similarData;
    var box = Books.getBooks();

    bookData = box.get(id);

    if (bookData == null) {
      throw FetchDataError('Something went wrong');
    }

    similarData = BookModelList.fromBox(box);

    return [
      bookData,
      similarData.books,
    ];
  }
}

// List<BookInfoModel> booksModel = [
//   BookInfoModel(
//     title: "title",
//     poster: "poster",
//     id: "3",
//     voteAverage: 4,
//     releaseDate: "releaseDate",
//   ),
//   BookInfoModel(
//     title: "title",
//     poster: "poster",
//     id: "3",
//     voteAverage: 4,
//     releaseDate: "releaseDate",
//   ),
//   BookInfoModel(
//     title: "title",
//     poster: "poster",
//     id: "3",
//     voteAverage: 4,
//     releaseDate: "releaseDate",
//   ),
// ];
