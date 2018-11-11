import 'package:flutter/material.dart';
import 'package:sample_flutter/bloc/photo_bloc.dart';

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
  final _bloc = PhotoBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: _bloc.photos,
      initialData: List<String>(),
      builder: (context, snapshot) {
        return GridView.count(
          crossAxisCount: 2,
          children: snapshot.data.map((source) {
            final name = "image${snapshot.data.indexOf(source)}";
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailWidget(name, source);
                }));
              },
              child: Hero(
                tag: name,
                child: Card(
                  child: Image.network(
                    source,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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
