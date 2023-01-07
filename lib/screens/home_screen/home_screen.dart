import 'package:booksapp/animation.dart';
import 'package:booksapp/widgets/header_text.dart';
import 'package:booksapp/widgets/horizontal_list_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_model.dart';
import '../../widgets/book_home.dart';
import '../../widgets/error_page.dart';
import 'bloc/fetch_home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchHomeBloc()..add(FetchHomeData()),
      child: BlocBuilder<FetchHomeBloc, FetchHomeState>(
        builder: (context, state) {
          if (state is FetchHomeLoaded) {
            return HomeScreenWidget(
              tranding: state.tranding,
              topRated: state.topRated,
            );
          } else if (state is FetchHomeError) {
            return const ErrorPage();
          } else if (state is FetchHomeLoading) {
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

class HomeScreenWidget extends StatelessWidget {
  final List<BookModel> tranding;
  final List<BookModel> topRated;
  const HomeScreenWidget({
    Key? key,
    required this.tranding,
    required this.topRated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BooksPage(books: topRated),
            const DelayedDisplay(
                delay: Duration(microseconds: 800),
                child: HeaderText(text: "Лучшие за неделю")),
            DelayedDisplay(
              delay: const Duration(microseconds: 800),
              child: HorizontalListViewBooks(
                list: tranding,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const HeaderText(text: "Бестселлеры"),
            HorizontalListViewBooks(
              list: topRated,
            ),
          ],
        ),
      ),
    );
  }
}
