import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatefulWidget {
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<SecondPage> {
  String? data;
  late var fatchData;

  loadJson() async{
    data = await rootBundle.loadString('assets/Products.json');
    fatchData = await jsonDecode(data!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(
          'Order Summary', style: TextStyle(fontWeight: FontWeight.bold)
      ),
        centerTitle: true,
      ),
      body: (data == null)? CircularProgressIndicator.adaptive() : ListView.builder(
        itemCount: 2,
        itemBuilder: (context , index) => Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                onBackgroundImageError: null,
                backgroundImage: NetworkImage(fatchData[index]["picture"]),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      fatchData[index]["productName"], style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Qty: 25"),
                      SizedBox(width: 50),
                      Text("price: ${fatchData[index]["price"]}"),
                    ],
                  ),
                  Text("Selected Color: Green"),
                  Text("Selected Brand: Yang Dean"),
                  Text("Total Price: ${(1440.19 * 25)}" ),
                  SizedBox(height: 10)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}