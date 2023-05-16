import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
class AllBLEDevices extends StatefulWidget {
  const AllBLEDevices({super.key, required this.title});
  final String title;
  @override
  State<AllBLEDevices> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AllBLEDevices> {

  String _data1 = '';
  bool _scanning1 = false;
  int _counter1 = 1;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();
  @override
  void initState() {
    super.initState();
    _bluetooth.devices.listen((device) {
      setState(() {
          _data1 += '$_counter1. ' + device.name+' - ${device.address}\n';
          _counter1++;
      });
    });
    _bluetooth.scanStopped.listen((device) {
      setState(() {
        _scanning1 = false;
        _data1 += '\nscanning stopped';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[250],
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.yellow[700],
          foregroundColor: Colors.black,
        ),
        body:
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: ListView(children: [
                  Center(
                    child: Text(
                      'Name - Address',
                    ),
                  ),
                  Text(
                    _data1,
                  ),
                ],)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _scanning1 ? Colors.red : Colors.yellow[700],
                            shadowColor: Colors.yellow[700],
                            foregroundColor: Colors.black,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            minimumSize: Size(100, 50), //////// HERE
                          ),
                          child: Text(_scanning1 ? 'Stop' : 'Start'),
                          onPressed: () async {
                            try {
                              _counter1 = 1;
                              if(_scanning1) {
                                await _bluetooth.stopScan();
                              }
                              else {
                                _data1 = '';
                                await _bluetooth.startScan(pairedDevices: false);
                                setState(() {
                                  _scanning1 = true;
                                });
                              }
                            } on PlatformException catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),),
                        Expanded(child: FilledButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[700],
                              shadowColor: Colors.yellow[700],
                              foregroundColor: Colors.black,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              minimumSize: Size(100, 50), //////// HERE
                            ),
                            onPressed: (){
                              setState(() {
                                _data1 = "";
                              });
                            }, child: Text("Clear")),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}