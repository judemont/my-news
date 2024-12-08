import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news/models/news.dart';
import 'dart:math';


const baseUrl = "gnews.io";
const apiKeys = ["2f1c29fafced986def5a1abe3aef893d"];

Future<List<News>> getNews({int limit = 10, String category = "general"}) async{
 Map<String, dynamic> queryParameters = {
    'apikey': apiKeys[Random().nextInt(apiKeys.length)],
    'max': limit.toString(),
    'category': category,
    'lang': "fr",
    'country': "ch",
  };

  Uri url = Uri.https(baseUrl, "api/v4/top-headlines", queryParameters);
  print(url);
  final response = await http.get(url);
  var body = jsonDecode(response.body);
  List news = body['articles'];

  return news.map((news) => News(
    title: news["title"],
    imgUrl: news["image"],
    description: news["description"],
  )).toList();
}