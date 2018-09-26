import 'package:flutter/material.dart';
import 'package:sample_flutter/data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Sample"),
      ),
      body: ImagesGridWidget(),
    );
  }
}

class ImagesGridWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImagesState();
}

class ImagesState extends State<ImagesGridWidget> {
  final _dataSource = ImageDataSource();
  var _list = List<String>();

  @override
  void initState() {
    _dataSource.getPhoto().then((value) {
      setState(() {
        _list = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: _list.map((source) {
        final name = "image${_list.indexOf(source)}";
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailWidget(name, source);
            }));
          },
          child: Card(
            child: Hero(
              tag: name,
              child: Image.network(
                source,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String name;
  final String url;

  DetailWidget(this.name, this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: name,
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}
