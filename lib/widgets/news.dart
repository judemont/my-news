import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_news/models/crypto.dart';
import 'package:my_news/models/article.dart';
import 'package:my_news/services/api.dart';
import 'package:my_news/widgets/cryptos.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var newsDuration = const Duration(seconds: 5);
  List<String> cryptosSelection = ["bitcoin"];
  Article news = Article();
  List<Article> newsList = [];
  bool isLoading = true;

  List<Crypto> cryptos = [];

  @override
  void initState() {
    updateNews().then((_) {
      changeNews();
      print((newsList).map((e) => (e.title)));
    });
    // loadCryptos();

    Timer.periodic(newsDuration, (timer) {
      // loadCryptos();
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

  Future<void> loadCryptos() async {
    List<Crypto> cryptos_ = [];
    for (var crypto in cryptosSelection) {
      Crypto? crypto_ = await getCoinData(crypto);
      if (crypto_ != null) {
        cryptos_.add(crypto_);
      }
    }
    setState(() {
      cryptos = cryptos_;
    });
  }

  Future<void> updateNews() async {
    isLoading = true;
    List<Article> newsList_ = await getNews();
    newsList_.add(await randomWikipediaArticle());
    print((newsList_).map((e) => (e.title)));

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
        //   title: const Text('My Article'),
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
                  alignment: const Alignment(0, 0.7),
                  child: Text(
                    news.description ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 45, backgroundColor: Colors.white),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: CryptoView(cryptos: cryptos),
                // )
              ]));
  }
}
