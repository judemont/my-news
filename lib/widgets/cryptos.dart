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
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          // borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // spacing: 60,
            // spacing: 50,
            children: widget.cryptos
                .map((crypto) => Container(
                      child: Wrap(
                        spacing: 5,
                        children: [
                          Image.network(
                            crypto.logoUrl!,
                            width: 45,
                            height: 45,
                          ),
                          Text(
                            crypto.name!,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            formatePrice(crypto.price, "\$").toString(),
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            "${crypto.priceChangePercentageDay}%",
                            style: TextStyle(
                                fontSize: 20,
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
