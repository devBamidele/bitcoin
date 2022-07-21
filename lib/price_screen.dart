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
  List<int> exchangeList = List.filled(3, 1);
  // var lst = new List(3);
  //<int>
  displaySb(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(ksnackBar(message));

  ksnackBar(String message) {
    SnackBar(
      duration: const Duration(milliseconds: 1200),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic),
      ),
    );
  }

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

  showTiles() {
    List<MyCard> myCards = [];
    for (int i = 0; i < cryptoList.length; i++) {
      var newItem = MyCard(
          selectedCurrency: selectedCurrency,
          bitCoinCurrency: cryptoList[i],
          amount: exchangeList[i]);
      myCards.add(newItem);
    }
    return myCards;
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    CoinData coinData = CoinData();

    for (int i = 0; i < cryptoList.length; i++) {
      dynamic bitcoin = await coinData.getBitcoin(
          crypto: cryptoList[i], currency: selectedCurrency);
      if (bitcoin != null) {
        if (bitcoin == 'Bad response') {
          setState(() {
            exchangeList[i] = 0;
          });
        } else {
          setState(() {
            exchangeList[i] = bitcoin['rate'].toInt();
          });
        }
      } else {
        displaySb('No internet connection');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
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
                  bitCoinCurrency: cryptoList[0],
                  amount: exchangeList[0],
                ),
                const SizedBox(height: 15),
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: cryptoList[1],
                  amount: exchangeList[1],
                ),
                const SizedBox(height: 15),
                MyCard(
                  selectedCurrency: selectedCurrency,
                  bitCoinCurrency: cryptoList[2],
                  amount: exchangeList[2],
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
