import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends Equatable {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String poster;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String? releaseDate;

  @HiveField(4)
  final String? overview;

  @HiveField(5)
  final int? cost;

  @HiveField(6)
  final String? genre;

  @HiveField(7)
  final double? rateing;

  @HiveField(8)
  final String? writer;

  @HiveField(9)
  final int? page;

  const BookModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.releaseDate,
    required this.overview,
    required this.cost,
    required this.genre,
    required this.rateing,
    required this.writer,
    required this.page,
  });

  BookModel copyWith({
    String? title,
    String? poster,
    String? id,
    String? releaseDate,
    String? overview,
    int? cost,
    String? genre,
    double? rateing,
    String? writer,
    int? page,
  }) {
    return BookModel(
      title: title ?? this.title,
      poster: poster ?? this.poster,
      id: id ?? this.id,
      releaseDate: releaseDate ?? this.releaseDate,
      overview: overview ?? this.overview,
      cost: cost ?? this.cost,
      genre: genre ?? this.genre,
      rateing: rateing ?? this.rateing,
      writer: writer ?? this.writer,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      poster,
      id,
    ];
  }
}

class BookModelList {
  final List<BookModel> books;
  BookModelList({
    required this.books,
  });

  factory BookModelList.fromBox(Box<dynamic> box) {
    List<BookModel> books = [];

    for (int i = 0; i < box.length; i++) {
      books.add(box.getAt(i));
    }

    return BookModelList(books: books);
  }
}
