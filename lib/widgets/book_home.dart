import 'dart:ui';

import 'package:booksapp/screens/book_info_screen/book_Info_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../animation.dart';
import '../constants.dart';
import '../models/book_model.dart';

class BooksPage extends StatefulWidget {
  final List<BookModel> books;
  const BooksPage({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .56,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: .6,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      "Лучшие книги",
                      style: heading.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 26,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: DelayedDisplay(
              delay: const Duration(microseconds: 800),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.4,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.75,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: widget.books.map((book) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: () {
                          pushNewScreen(
                              context,
                              BookDetailsScreen(
                                id: book.id,
                              ));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      boxShadow: kElevationToShadow[8],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DelayedDisplay(
                                      delay: const Duration(microseconds: 800),
                                      slidingBeginOffset:
                                          const Offset(0.0, -0.01),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: book.poster,
                                          width: double.infinity,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .38) *
                                              .6,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Container(
                                            color: Colors.grey.shade900,
                                          ),
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  if (_current == widget.books.indexOf(book))
                                    DelayedDisplay(
                                      delay: const Duration(microseconds: 800),
                                      slidingBeginOffset:
                                          const Offset(0.0, -0.10),
                                      child: Text(
                                        book.title,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  const SizedBox(height: 6),
                                  if (_current == widget.books.indexOf(book))
                                    DelayedDisplay(
                                      delay: const Duration(microseconds: 900),
                                      slidingBeginOffset:
                                          const Offset(0.0, -0.10),
                                      child: Text(
                                        book.releaseDate ?? 'Дата неизвестна',
                                        style: normalText.copyWith(
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
