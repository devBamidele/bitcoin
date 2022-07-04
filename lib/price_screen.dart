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
        log(selectedPicker.toString());
      },
      children: myItems,
    );
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
                    selectedCurrency: selectedCurrency, bitCoinCurrency: 'BTC'),
                const SizedBox(height: 18),
                MyCard(
                    selectedCurrency: selectedCurrency, bitCoinCurrency: 'ETH'),
                const SizedBox(height: 18),
                MyCard(
                    selectedCurrency: selectedCurrency, bitCoinCurrency: 'LTC'),
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
                : getAndroidPicker(), // The IOS is really the only platform that needs the unique picker
          ),
        ],
      ),
    );
  }
}
