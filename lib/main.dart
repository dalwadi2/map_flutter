import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _state createState() => new _state();
}

class _state extends State<MyApp> {
  List<LatLng> pointsPoly;

  MapController mapController;
  Map<String, LatLng> cords;
  List<Marker> dynamicMarkers;
  List<Marker> polyMarkers;

  @override
  void initState() {
    super.initState();
    mapController = new MapController();

    pointsPoly = new List();

    pointsPoly.add(new LatLng(23.112986, 72.570099));
    pointsPoly.add(new LatLng(23.115552, 72.588810));
    pointsPoly.add(new LatLng(23.103947, 72.582201));

    cords = new Map<String, LatLng>();

    cords.putIfAbsent("One", () => new LatLng(23.1052013, 72.5961823));
    cords.putIfAbsent("Two", () => new LatLng(23.106783, 72.592206));
    cords.putIfAbsent("Three", () => new LatLng(23.104480, 72.588028));

    dynamicMarkers = new List<Marker>();
    polyMarkers = new List<Marker>();

    for (int i = 0; i < cords.length; i++) {
      dynamicMarkers.add(
        new Marker(
          width: 80.0,
          height: 80.0,
          point: cords.values.elementAt(i),
          builder: (context) => new Icon(
                Icons.pin_drop,
                color: Colors.black87,
              ),
        ),
      );
    }
    for (int i = 0; i < pointsPoly.length; i++) {
      polyMarkers.add(
        new Marker(
          width: 80.0,
          height: 80.0,
          point: pointsPoly.elementAt(i),
          builder: (context) => new Icon(
                Icons.pin_drop,
                color: Colors.lightGreen,
              ),
        ),
      );
    }
  }

  void showCord(int index) {
    mapController.move(cords.values.elementAt(index), 18.0);
  }

  List<Widget> makeButtons() {
    List<Widget> list = new List();

    for (int i = 0; i < cords.length; i++) {
      list.add(new RaisedButton(
        onPressed: () => showCord(i),
        child: new Text(cords.keys.elementAt(i)),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      new Marker(
        width: 80.0,
        height: 80.0,
        point: new LatLng(23.10303, 72.59571),
        builder: (context) => new Icon(
              Icons.pin_drop,
              color: Colors.red,
            ),
      ),
      new Marker(
        width: 80.0,
        height: 80.0,
        point: new LatLng(23.09805, 72.58811),
        builder: (context) => new Icon(
              Icons.pin_drop,
              color: Colors.blue,
            ),
      ),
      new Marker(
        width: 80.0,
        height: 80.0,
        point: new LatLng(23.11138, 72.59180),
        builder: (context) => new Icon(
              Icons.pin_drop,
              color: Colors.orangeAccent,
            ),
      ),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Title'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Row(
                children: makeButtons(),
              ),
              new Flexible(
                child: new FlutterMap(
                  mapController: mapController,
                  options: new MapOptions(
                    center: new LatLng(23.10303, 72.59571),
                    zoom: 15.0,
                  ),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(markers: markers),
                    // this are dynamic markers
                    new MarkerLayerOptions(markers: dynamicMarkers),
                    new MarkerLayerOptions(markers: polyMarkers),
                    new PolylineLayerOptions(
                      polylines: [
                        new Polyline(
                            points: pointsPoly,
                            strokeWidth: 4.0,
                            color: Colors.purple)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
