import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_news/models/news.dart';
import 'package:my_news/services/api.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var newsDuration = const Duration(seconds: 10);
  News news = News();
  List<News> newsList = [];
  bool isLoading = true;

  @override
  void initState() {
    updateNews().then((_) {
      changeNews();
    });

    Timer.periodic(newsDuration, (timer) {
      if (newsList.isEmpty) {
        updateNews().then((_) {
          changeNews();
        });
      } else {
        changeNews();
      }
    });

    super.initState();
  }

  Future<void> updateNews() async {
    print("BB");

    isLoading = true;
    List<News> newsList_ = await getNews();
    setState(() {
      newsList = newsList_;
      isLoading = false;
    });
  }

  void changeNews() {
    setState(() {
      news = newsList[Random().nextInt(newsList.length)];
      newsList.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('My News'),
        // ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(news.imgUrl ?? ""))),
                ),
                Align(
                  alignment: const Alignment(0, -0.7),
                  child: Text(
                    news.title ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 55,
                        backgroundColor: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.8),
                  child: Text(
                    news.description ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 45, backgroundColor: Colors.white),
                  ),
                ),
              ]));
  }
}
