import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'cart_button_state.dart';

class CartButtonCubit extends Cubit<CartButtonState> {
  CartButtonCubit() : super(CartButtonState.initial());

  void init(String id) {
    var box = Hive.box('Cart');
    var value = box.containsKey(id);

    if (value) {
      emit(state.copyWith(inCart: true));
    } else {
      emit(state.copyWith(inCart: false));
    }
  }

  void like({
    required String id,
    required String title,
    required String poster,
    required double rating,
    required String type,
    required String date,
  }) {
    var box = Hive.box('Cart');
    if (state.inCart) {
      box.delete(id);
      emit(state.copyWith(inCart: false));
    } else {
      emit(state.copyWith(inCart: true));

      box.put(id, {
        'id': id,
        'title': title,
        'poster': poster,
        'rating': rating,
        'type': type,
        'date': date,
      });
    }
  }
}
