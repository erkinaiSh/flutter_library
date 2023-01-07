part of 'book_info_bloc.dart';

abstract class BookInfoState extends Equatable {
  const BookInfoState();

  @override
  List<Object> get props => [];
}

class BookInfoInitial extends BookInfoState {}

class BookInfoLoading extends BookInfoState {}

class BookInfoLoaded extends BookInfoState {
  final BookModel bookData;
  final List<BookModel> similar;

  const BookInfoLoaded({
    required this.bookData,
    required this.similar,
  });
}

class BookInfoError extends BookInfoState {
  final FetchDataError error;

  const BookInfoError({
    required this.error,
  });
}
