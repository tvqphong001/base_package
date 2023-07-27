import 'package:json_annotation/json_annotation.dart';

import '../../base.dart';

class JsonStringToInt implements JsonConverter<int, dynamic> {
  const JsonStringToInt();

  @override
  int fromJson(dynamic json) {
    if (json is num) {
      return json.toInt();
    }
    try{
      return int.tryParse(json) ?? 0;
    }catch(e){
      return 0;
    }
  }

  @override
  int toJson(int object) => object;
}

class JsonToNum implements JsonConverter<num, dynamic> {
  const JsonToNum();

  @override
  num fromJson(dynamic json) {
    if (json is num) {
      return json;
    }
    try{
      return num.tryParse(json) ?? 0;
    }catch(e){
      return 0;
    }
  }

  @override
  num toJson(num object) => object;
}

class JsonConvertToString implements JsonConverter<String, dynamic> {
  const JsonConvertToString();

  @override
  String fromJson(dynamic json) {
    if (json is String) {
      return json;
    }
    return (json ?? '').toString();
  }

  @override
  String toJson(String object) => object.toString();
}

// class JsonConvertToDateTime implements JsonConverter<DateTime, dynamic> {
//   const JsonConvertToDateTime();
//
//   @override
//   DateTime fromJson(dynamic json) {
//     if (json is String) {
//       return DateTime.parse(json);
//     }
//     return DateTime.now();
//   }
//
//   @override
//   String toJson(DateTime object) {
//     return object.date;
//   }
// }

// bool converter
class JsonConvertToBool implements JsonConverter<bool, dynamic> {
  const JsonConvertToBool();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) {
      return json;
    }
    return false;
  }

  @override
  bool toJson(bool object) {
    return object;
  }
}

// bool converter
class JsonConvertToDouble implements JsonConverter<double, dynamic> {
  const JsonConvertToDouble();

  @override
  double fromJson(dynamic json) {
    if (json is num) {
      return json.toDouble();
    }
    try{
      return double.tryParse(json) ?? 0.0;
    }catch(e){
      return 0.0;
    }
  }

  @override
  double toJson(double object) {
    return object;
  }
}

// bool converter
class JsonConvertToList implements JsonConverter<List, dynamic> {
  const JsonConvertToList();

  @override
  List fromJson(dynamic json) {
    if (json is List) {
      return json.map((e) => e.fromJson(e as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  toJson(List object) {
    return object;
  }
}

List<dynamic> readValueList(Map map, String key) {
  final data = map[key];
  if (data == null) return [];
  if (data is List<dynamic>) return data;
  return [];
}

Map<String, dynamic> readValueObject(Map map, String key) {
  final data = map[key];
  if (data == null) return {};
  if (data is Map) return data as Map<String, dynamic>;
  return {};
}

const $appConverter = <JsonConverter>[
  JsonConvertToString(),
  JsonStringToInt(),
  // JsonConvertToDateTime(),
  JsonConvertToBool(),
  JsonConvertToDouble(),
  JsonConvertToList(),
];
