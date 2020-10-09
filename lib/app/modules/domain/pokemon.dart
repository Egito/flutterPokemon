import 'dart:convert';

import 'package:flutter/foundation.dart';

class Pokemon {
  final String id;
  final List<dynamic> types;
  final String imageUrl;
  final String imageUrl1HiRes;
  final String name;

  Pokemon({
    @required this.id,
    @required this.imageUrl,
    @required this.imageUrl1HiRes,
    @required this.name,
    @required this.types,
  });

  String toJson() {
    Map<String, dynamic> json = _fromMapJson();
    return jsonEncode(json);
  }

  Map<String, dynamic> _fromMapJson() {
    return {
      'id': id,
      'types': types,
      'imageUrl': imageUrl,
      'imageUrl1HiRes': imageUrl1HiRes,
      'name': name,
    };
  }
}
