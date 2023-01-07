import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

import '../../../data/fetch_book_data_by_id.dart';
import '../../../models/error_model.dart';
import '../../../models/book_model.dart';

part 'book_info_event.dart';
part 'book_info_state.dart';

class BookInfoBloc extends Bloc<BookInfoEvent, BookInfoState> {
  final repo = FetchBookDataById();

  BookInfoBloc() : super(BookInfoInitial()) {
    on<BookInfoEvent>((event, emit) async {
      if (event is LoadBooksInfo) {
        try {
          emit(BookInfoLoading());
          
          final List<dynamic> info = await repo.getDetails(event.id);

          emit(BookInfoLoaded(
            bookData: info[0],
            similar: info[1],
          ));
        } on FetchDataError catch (e) {
          emit(BookInfoError(error: e));
        } catch (e) {
          emit(BookInfoError(error: FetchDataError(e.toString())));
        }
      }
    });
  }
}
