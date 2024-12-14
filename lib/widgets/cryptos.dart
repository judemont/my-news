import 'package:flutter/material.dart';
import 'package:my_news/models/crypto.dart';
import 'package:my_news/utils.dart';

class CryptoView extends StatefulWidget {
  final List<Crypto> cryptos;
  const CryptoView({super.key, required this.cryptos});

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Wrap(
            spacing: 50,
            children: widget.cryptos
                .map((crypto) => Container(
                      child: Column(
                        children: [
                          Image.network(
                            crypto.logoUrl!,
                            width: 25,
                            height: 25,
                          ),
                          Text(crypto.name!),
                          Text(formatePrice(crypto.price, "\$").toString()),
                          Text(
                            crypto.priceChangePercentageDay.toString(),
                            style: TextStyle(
                                color: crypto.priceChangePercentageDay! > 0
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                    ))
                .toList()));
  }
}
