import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "BLE/allBLEDevices.dart";
import "BLE/CGMBLEDevices.dart";
import "BLE/customBLEFilter.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const header = 'Bluetooth sniffer';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: header,
      home: MyHomePage(title: header),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue[900],
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            bottom:
            PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: TabBar(
                tabs: [
                  Tab(text: "All devices",),
                  Tab(text: "CGM devices",),
                  Tab(text: "Custom Filter",),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AllBLEDevices(title: "Get All Devices"),
              CGMBLEDevices(title: "Get CGM Devices"),
              customBLEFilter(title: "Get Devices"),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.7,
        child: Column(
          children: [
            Expanded(child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF0D47A1),
                  ),
                  child: Text(
                    'About',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ]
            )),
            Container(child: Align(alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                title: const Text('© Stanislav Polishchuk', textAlign: TextAlign.center,),
                subtitle: Text("Developed with educational purposes only.\n\nV1.0", textAlign: TextAlign.center,),
              ),
            ),),
          ],
        )
      ),
    );
  }
}