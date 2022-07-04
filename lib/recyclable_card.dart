import 'package:flutter/material.dart';

/// The card that displays exchange rates
class MyCard extends StatefulWidget {
  const MyCard({
    Key? key,
    required this.selectedCurrency,
    required this.bitCoinCurrency,
    required this.amount,
  }) : super(key: key);

  final String bitCoinCurrency;
  final String selectedCurrency;
  final String? amount;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 ${widget.bitCoinCurrency} = ${widget.amount ?? '?'}  ${widget.selectedCurrency}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
