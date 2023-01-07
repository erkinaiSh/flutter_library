import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../widgets/book_card.dart';
import '../../widgets/error_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            largeTitle: const Text(
              'Корзина',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            border: Border(
              bottom: BorderSide(
                width: .6,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder<Box>(
                valueListenable: Hive.box('Cart').listenable(),
                builder: (context, box, child) {
                  if (box.isEmpty) {
                    return const EmptyCart();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      final info = box.getAt(i);

                      return Dismissible(
                        key: Key(info['id'].toString()),
                        onDismissed: (direction) {
                          box.deleteAt(i);
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              CupertinoIcons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: HorizontalBookCard(
                          poster: info['poster'],
                          name: info['title'],
                          date: info['releaseDate'] ?? "Дата неизвестна",
                          id: info['id'],
                          color: Colors.white,
                          rate: info['rating'],
                        ),
                      );
                    },
                    itemCount: box.length,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
