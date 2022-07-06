import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin/coin_data.dart';
import 'package:bitcoin/recyclable_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int? btcrate, ethrate, ltcrate;
  List<int> exchange = [];

  getAndroidPicker() {
    List<DropdownMenuItem<String>> items =
        []; // Create an empty list of DropdownMenuItems
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        // Create the menuItems
        value: currency,
        child: Text(currency),
      );
      items.add(newItem); // Add them to the list
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!;
            getData();
          },
        );
      },
    );
  }

  getIOsPicker() {
    List<Text> myItems = []; // Make an empty list of Texts

    for (String currency in currenciesList) {
      var text = Text(currency);
      myItems.add(text);
    }

    return CupertinoPicker(
      magnification: 1.2,
      squeeze: 1.2,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedPicker) {
        setState(() {
          selectedCurrency = currenciesList[selectedPicker];
          getData();
          log(exchange.length.toString());
        });
      },
      children: myItems,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Todo: The getData needs to receive responses and store it in an array
  void getData() async {
    CoinData coinData = CoinData();

    for (int i = 0; i < cryptoList.length; i++) {
      dynamic bitcoin = await coinData.getBitcoin(selectedCurrency);

      if (bitcoin != null) {
        if (bitcoin == 'Bad response') {
          btcrate = null; // This line is not necessary btw
        } else {
          double result = bitcoin['rate'];
          exchange.add(result.toInt());
          setState(
            () {
              btcrate = exchange[i];
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('🤑 Coin Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // todo: Add the remaining cards and set the amount: to be arraylist[0] or so
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: 'BTC',
                  amount: btcrate.toString(),
                ),
                const SizedBox(height: 15),
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: 'BTC',
                  amount: btcrate.toString(),
                ),
                const SizedBox(height: 15),
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: 'BTC',
                  amount: btcrate.toString(),
                ),
              ],
            ),
          ),
          Container(
            height: 130.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.lightBlue,
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(bottom: 15),
            child: Platform.isIOS
                ? getIOsPicker()
                : getIOsPicker(), // The IOS is really the only platform that needs the unique picker
          ),
        ],
      ),
    );
  }
}
