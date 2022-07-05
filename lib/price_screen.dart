import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin/coin_data.dart';
import 'package:bitcoin/recyclable_card.dart';
import 'dart:io' show Platform;

// BTC
// ETH
// LTE

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int? btcrate, ethrate, ltcrate;

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

  void getData() async {
    CoinData coinData = CoinData();

    dynamic bitcoin = await coinData.getBitcoin(selectedCurrency);

    if (bitcoin != null) {
      if (bitcoin == 'Bad response') {
        btcrate = null;
      } else {
        double result = bitcoin['rate'];
        setState(() {
          btcrate = result.toInt();
        });
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
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: 'BTC',
                  amount: btcrate.toString(),
                ),
                const SizedBox(height: 30),
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: 'BTC',
                  amount: btcrate.toString(),
                ),
                const SizedBox(height: 30),
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
