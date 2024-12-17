import 'package:flutter_wonderous_clone_app/logic/data/unsplash_photo_data.dart';
import 'package:flutter_wonderous_clone_app/logic/unsplash_service.dart';
import 'package:get_it/get_it.dart';

class UnsplashLogic {
  final Map<String, List<String>> _idsByCollection =
      UnsplashPhotoData.photosByCollectionId;

  UnsplashService get service => GetIt.I.get<UnsplashService>();

  List<String>? getCollectionPhotos(String collectionId) =>
      _idsByCollection[collectionId];
}
