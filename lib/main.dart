import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/second_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          'Product Lists', style: TextStyle(fontWeight: FontWeight.bold)
      ),
        centerTitle: true,
      ),
      body: (data == null)? CircularProgressIndicator.adaptive() : SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: fatchData.length,
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
                        Text("price: ${fatchData[index]["price"]}"),
                        RadioButton(data: fatchData[index]),
                        SizedBox(height: 10)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox( height: 20),
            SizedBox(width: MediaQuery.of(context).size.width*.8,
                child: MaterialButton(color: Colors.grey,onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                } , child: Text("Submit Product"),))
          ],
        ),
      ),
    );
  }
}
class RadioButton extends StatefulWidget {
  RadioButton({Key? key, required this.data}) : super(key: key);
  var data;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String radioItem  = "";
  String? brand;
  String? qty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.data["colors"].map<Widget>((items) {
            return Row(
              children: [
                Radio<String>(
                  groupValue: radioItem,
                  value: items,
                  onChanged: (value) {
                    setState(() {
                      radioItem = value!;
                    });
                  },
                ),
                Text(items),
              ],
            );
          }).toList(),
        ),
        DropdownButton<String>(
          value: brand,
          hint: Text("Select Brand"),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: widget.data["brands"].map<DropdownMenuItem<String>>((item) {
            return DropdownMenuItem<String>(
              value: item["name"],
              child: Text(item["name"]),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              brand = newValue! as String;
            });
          },
        ),
        SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width *.8,
          child: TextField(
            onChanged: (number) {
              qty = number;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Qty',
            ),
          ),
        ),
      ],
    );
  }
}