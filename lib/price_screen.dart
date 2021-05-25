import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'Networking.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String toCurr = 'USD';
  String fromCurr = 'BTC';
  List<int> rate = [null,null,null];

  CupertinoPicker iosPicker() {
    List<Widget> listofwidgets = [];
    for (String item in currenciesList) {
      var newItem;
      newItem = Text(
        item,
        style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400),
      );
      listofwidgets.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40.0,
      onSelectedItemChanged: (selectedIndex) async {
        toCurr = currenciesList[selectedIndex];
       initRate(fromCurr, toCurr);
      },
      children: listofwidgets,
    );
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> dropDownList = [];
    for (String item in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropDownList.add(newItem);
    }
    return DropdownButton<String>(
      value: toCurr,
      items: dropDownList,
      onChanged: (value) async {
        toCurr = value;
        initRate(fromCurr, toCurr);
      },
    );
  }

  void initRate(fromCurr, toCurr) async {
    List newList = [];
    var temp =  await NetworkHelper(cryptoList[0], toCurr).getCurrencyData();
    newList.add(temp.toInt());
    temp =  await NetworkHelper(cryptoList[1], toCurr).getCurrencyData();
    newList.add(temp.toInt());
    temp =  await NetworkHelper(cryptoList[2], toCurr).getCurrencyData();
    newList.add(temp.toInt());
    setState(() {
      rate[0] = newList[0].toInt();
      rate[1] = newList[1].toInt();
      rate[2] = newList[2].toInt();

    });
  }

  @override
  void initState(){
    super.initState();
    initRate(fromCurr, toCurr);
  }
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
            child: Column(
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${cryptoList[0]} = ${rate[0]} $toCurr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${cryptoList[1]} = ${rate[1]} $toCurr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ${cryptoList[2]} = ${rate[2]} $toCurr',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 10.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
