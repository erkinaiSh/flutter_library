import 'package:booksapp/screens/book_info_screen/book_Info_screen.dart';
import 'package:flutter/material.dart';

import '../animation.dart';
import '../models/book_model.dart';
import 'book_card.dart';

class HorizontalListViewBooks extends StatelessWidget {
  final List<BookModel> list;
  final Color? color;
  const HorizontalListViewBooks({
    Key? key,
    required this.list,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 310,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 7),
            for (var i = 0; i < list.length; i++)
              BookCard(
                id: list[i].id,
                name: list[i].title,
                poster: list[i].poster,
                color: color == null ? Colors.white : color!,
                date: list[i].releaseDate!,
                onTap: () {
                  pushNewScreen(
                    context,
                    BookDetailsScreen(
                      id: list[i].id,
                    ),
                  );
                },
              )
          ],
        ));
  }
}
