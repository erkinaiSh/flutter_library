import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cart_button_cubit.dart';

class CartButton extends StatelessWidget {
  final String id;
  final String date;
  final String title;
  final String poster;
  final String type;
  final double rate;
  const CartButton({
    Key? key,
    required this.id,
    required this.date,
    required this.title,
    required this.poster,
    required this.type,
    required this.rate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartButtonCubit()..init(id),
      child: BlocBuilder<CartButtonCubit, CartButtonState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: kElevationToShadow[2]),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.5),
                ),
                child: InkWell(
                  onTap: () {
                    BlocProvider.of<CartButtonCubit>(context).like(
                        date: date,
                        id: id,
                        poster: poster,
                        rating: rate,
                        title: title,
                        type: type);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      !state.inCart
                          ? const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                              size: 30,
                            )
                          : const Icon(
                              Icons.shopping_cart,
                              color: Colors.amber,
                              size: 30,
                            ),
                      const SizedBox(width: 10),
                      Text(
                        !state.inCart
                            ? "Добавить в корзину"
                            : "Добавлен в корзину",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
