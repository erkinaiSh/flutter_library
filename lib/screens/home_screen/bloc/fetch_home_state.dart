part of 'fetch_home_bloc.dart';

@immutable
abstract class FetchHomeState {}

class FetchHomeInitial extends FetchHomeState {}

class FetchHomeLoading extends FetchHomeState {}

class FetchHomeLoaded extends FetchHomeState {
  final List<BookModel> tranding;
  final List<BookModel> topRated;
  FetchHomeLoaded({
    required this.tranding,
    required this.topRated,
  });
}

class FetchHomeError extends FetchHomeState {
  final FetchDataError error;
  FetchHomeError({
    required this.error,
  });
}
