part of 'book_info_bloc.dart';

abstract class BookInfoEvent extends Equatable {
  const BookInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadBooksInfo extends BookInfoEvent {
  final String id;

  const LoadBooksInfo({
    required this.id,
  });
}
