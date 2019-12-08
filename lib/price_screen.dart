import 'dart:async';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/network/ticker_repository.dart';
import 'package:flutter/material.dart';

class PriceScreenViewModel {
  TickerRepository tickerRepository;

  PriceScreenViewModel() {
    tickerRepository = TickerRepository();
  }

  Future<Map<String, String>> getCoinPrices(String currency) async {
    return await tickerRepository.getCoinPrices(currency);
  }
}

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  StreamController<String> currencyStream;

  PriceScreenViewModel viewModel;

  String btcPrice;
  String ethPrice;
  String ltcPrice;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    currencyStream.close();
  }

  @override
  void initState() {
    super.initState();
    viewModel = PriceScreenViewModel();
    currencyStream = StreamController();
    currencyStream.add(selectedCurrency);
    currencyStream.stream.listen((currency) async {
      Map<String, String> priceData =
          await viewModel.getCoinPrices(selectedCurrency);
      setState(() {
        btcPrice = priceData['BTC'];
        ethPrice = priceData['ETH'];
        ltcPrice = priceData['LTC'];
      });
    });
  }

  List<DropdownMenuItem<String>> getMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    currenciesList.forEach((currency) {
      items.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    });
    return items;
  }

  CoinData coinData = CoinData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btcPrice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $ethPrice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $ltcPrice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getMenuItems(),
              onChanged: (item) {
                setState(() {
                  selectedCurrency = item;
                  currencyStream.add(selectedCurrency);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
