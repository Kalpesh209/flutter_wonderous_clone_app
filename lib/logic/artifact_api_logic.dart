import 'dart:collection';

import 'package:flutter_wonderous_clone_app/logic/artifact_api_service.dart';
import 'package:flutter_wonderous_clone_app/logic/common/http_client.dart';
import 'package:flutter_wonderous_clone_app/logic/data/artifact_data.dart';
import 'package:flutter_wonderous_clone_app/main.dart';
import 'package:get_it/get_it.dart';

class ArtifactAPILogic {
  final HashMap<String, ArtifactData?> _artifactCache = HashMap();

  ArtifactAPIService get service => GetIt.I.get<ArtifactAPIService>();

  /// Returns artifact data by ID. Returns null if artifact cannot be found. */
  Future<ArtifactData?> getArtifactByID(String id,
      {bool selfHosted = false}) async {
    if (_artifactCache.containsKey(id)) return _artifactCache[id];
    ServiceResult<ArtifactData?> result = (await (selfHosted
        ? service.getSelfHostedObjectByID(id)
        : service.getMetObjectByID(id)));
    if (!result.success) throw $strings.artifactDetailsErrorNotFound(id);
    ArtifactData? artifact = result.content;
    return _artifactCache[id] = artifact;
  }
}
