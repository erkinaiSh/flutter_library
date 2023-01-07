// ignore_for_file: file_names

import 'dart:ui';
import 'package:booksapp/widgets/cart_button/cart_button.dart';
import 'package:booksapp/widgets/horizontal_list_cards.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

import '../../animation.dart';
import '../../constants.dart';
import '../../models/book_model.dart';
import '../../widgets/expandable_group.dart';
import '../../widgets/error_page.dart';
import '../../widgets/star_icon_display.dart';
import 'bloc/book_info_bloc.dart';

class BookDetailsScreen extends StatefulWidget {
  final String id;
  const BookDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookInfoBloc()..add(LoadBooksInfo(id: widget.id)),
      child: BlocBuilder<BookInfoBloc, BookInfoState>(
        builder: (context, state) {
          if (state is BookInfoLoaded) {
            return BookDetailScreenWidget(
              info: state.bookData,
              similar: state.similar,
            );
          } else if (state is BookInfoError) {
            return const ErrorPage();
          } else if (state is BookInfoLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey.shade700,
                  strokeWidth: 2,
                  backgroundColor: Colors.cyanAccent,
                ),
              ),
            );
          }

          return const Scaffold();
        },
      ),
    );
  }
}

class BookDetailScreenWidget extends StatelessWidget {
  final BookModel info;
  final List<BookModel> similar;
  const BookDetailScreenWidget({
    Key? key,
    required this.info,
    required this.similar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: DelayedDisplay(
                    delay: const Duration(microseconds: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: kElevationToShadow[8],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: info.poster,
                          width: 120,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DelayedDisplay(
                          delay: const Duration(microseconds: 700),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: info.title,
                                  style: heading.copyWith(fontSize: 22),
                                ),
                                TextSpan(
                                  text: " (${info.releaseDate!.split("-")[0]})",
                                  style: heading.copyWith(
                                    color: Colors.white.withOpacity(.8),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        DelayedDisplay(
                          delay: const Duration(microseconds: 700),
                          child: Text(
                            info.genre ?? "Жанр книги не известно",
                            style: normalText.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 5),
                        DelayedDisplay(
                          delay: const Duration(microseconds: 700),
                          child: Row(
                            children: [
                              IconTheme(
                                data: const IconThemeData(
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                child: StarDisplay(
                                  value: info.rateing!.round(),
                                ),
                              ),
                              Text(
                                "  " + info.rateing.toString() + "/5",
                                style: normalText.copyWith(
                                  color: Colors.amber,
                                  letterSpacing: 1.2,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        DelayedDisplay(
                          delay: const Duration(microseconds: 800),
                          child: CartButton(
                            id: info.id,
                            title: info.title,
                            rate: info.rateing!,
                            poster: info.poster,
                            type: 'Book',
                            date: info.releaseDate!,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (info.overview != '')
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DelayedDisplay(
                      delay: const Duration(microseconds: 800),
                      child: Text("Обзор",
                          style: heading.copyWith(color: Colors.white))),
                  const SizedBox(height: 10),
                  DelayedDisplay(
                    delay: const Duration(microseconds: 1000),
                    child: ReadMoreText(
                      info.overview ?? "О книге не известно",
                      trimLines: 6,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'ещё',
                      trimExpandedText: 'скрыть',
                      style: normalText.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.white),
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ExpandableGroup(
            isExpanded: true,
            expandedIcon: Icon(
              Icons.arrow_drop_up,
              color: Colors.white != Colors.white ? Colors.black : Colors.white,
            ),
            collapsedIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white != Colors.white ? Colors.black : Colors.white,
            ),
            header: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                "О Книге",
                style: heading.copyWith(color: Colors.white),
              ),
            ),
            items: [
              ListTile(
                  title: Text(
                    "Автор книги",
                    style: heading.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  subtitle: Text(
                    info.writer ?? "Неизвестный автор",
                    style: normalText.copyWith(color: Colors.white),
                  )),
              ListTile(
                  title: Text(
                    "Объем",
                    style: heading.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  subtitle: Text(
                    '${info.page} стр',
                    style: normalText.copyWith(color: Colors.white),
                  )),
              ListTile(
                  title: Text(
                    "Жанр",
                    style: heading.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  subtitle: Text(
                    info.genre ?? "Жанр книги не известно",
                    style: normalText.copyWith(color: Colors.white),
                  )),
            ],
          ),
          if (similar.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text("Вам также может понравиться",
                      style: heading.copyWith(color: Colors.white)),
                ),
                HorizontalListViewBooks(list: similar, color: Colors.white)
              ],
            ),
        ],
      ),
    );
  }
}

class CreateIcons extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const CreateIcons({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: kElevationToShadow[2],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(.5),
            ),
            child: InkWell(onTap: onTap, child: child),
          ),
        ),
      ),
    );
  }
}
