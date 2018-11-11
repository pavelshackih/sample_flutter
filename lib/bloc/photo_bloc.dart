import 'dart:async';

import 'package:sample_flutter/api/pexels_api.dart';
import 'package:sample_flutter/bloc/base_bloc.dart';

class PhotoBloc extends BaseBloc {
  String _search = "cute animals";
  final _searchController = StreamController<String>();
  final _photosController = StreamController<List<String>>();

  Stream<List<String>> get photos => _photosController.stream;

  final _api = PexelsApi();

  PhotoBloc() {
    _searchController.stream.listen((data) async {
      final result = await _api.getPhotos(data);
      _photosController.add(result);
    });

    _searchController.add(_search);
  }

  void onPhotoSearch(String search) {
    _search = search;
    _searchController.add(_search);
  }

  @override
  void dispose() {
    _photosController.close();
    _searchController.close();
  }
}
