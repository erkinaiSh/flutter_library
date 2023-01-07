import 'package:flutter/material.dart';

import '../constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                size: 45,
                color: Colors.white.withOpacity(.6),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Что-то пошло не так!",
                style: heading.copyWith(color: Colors.white.withOpacity(.9)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Повторите попытку позже.",
                textAlign: TextAlign.center,
                style: normalText.copyWith(color: Colors.white.withOpacity(.9)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 45,
              color: Colors.white.withOpacity(.6),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Ваша корзина пуста",
              style: heading.copyWith(color: Colors.white.withOpacity(.9)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Добавьте свои любимые книги, чтобы отслеживать список корзины.",
              textAlign: TextAlign.center,
              style: normalText.copyWith(color: Colors.white.withOpacity(.9)),
            ),
          ],
        ),
      ),
    );
  }
}
