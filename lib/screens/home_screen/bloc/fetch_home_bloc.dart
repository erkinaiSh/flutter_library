import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/fetch_home_screen_data.dart';
import '../../../models/book_model.dart';
import '../../../models/error_model.dart';

part 'fetch_home_event.dart';
part 'fetch_home_state.dart';

class FetchHomeBloc extends Bloc<FetchHomeEvent, FetchHomeState> {
  final FetchHomeRepo repo = FetchHomeRepo();

  FetchHomeBloc() : super(FetchHomeInitial()) {
    on<FetchHomeEvent>((event, emit) async {
      if (event is FetchHomeData) {
        emit(FetchHomeLoading());
        try {
          final data = await repo.getHomePageBooks();

          emit(FetchHomeLoaded(
            tranding: data['tranding'],
            topRated: data['topRated'],
          ));
        } on FetchDataError catch (e) {
          emit(FetchHomeError(error: e));
        } catch (e) {
          emit(FetchHomeError(error: FetchDataError('something went wrong')));
        }
      }
    });
  }
}
