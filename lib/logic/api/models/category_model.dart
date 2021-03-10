// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  CategoryResponse({
    this.error,
    this.message,
    this.response,
  });

  final dynamic error;
  final String message;
  final List<CategoryData> response;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        response: json["response"] == null
            ? null
            : List<CategoryData>.from(
                json["response"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class CategoryData {
  CategoryData({
    this.id,
    this.iconClass,
    this.hierarchyAndName,
    this.name,
    this.fullTotal,
    this.total,
  });

  final int id;
  final IconClass iconClass;
  final String hierarchyAndName;
  final String name;
  final int fullTotal;
  final int total;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"] == null ? null : json["id"],
        iconClass: json["iconClass"] == null
            ? null
            : iconClassValues.map[json["iconClass"]],
        hierarchyAndName:
            json["hierarchyAndName"] == null ? null : json["hierarchyAndName"],
        name: json["name"] == null ? null : json["name"],
        fullTotal: json["fullTotal"] == null ? null : json["fullTotal"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "iconClass":
            iconClass == null ? null : iconClassValues.reverse[iconClass],
        "hierarchyAndName": hierarchyAndName == null ? null : hierarchyAndName,
        "name": name == null ? null : name,
        "fullTotal": fullTotal == null ? null : fullTotal,
        "total": total == null ? null : total,
      };
}

enum IconClass { FA_FA_FW_ICONPICKER_COMPONENT, FA_FA_FOLDER, FAS_FA_FILM }

final iconClassValues = EnumValues({
  "fas fa-film": IconClass.FAS_FA_FILM,
  "fa fa-folder": IconClass.FA_FA_FOLDER,
  "fa fa-fw iconpicker-component": IconClass.FA_FA_FW_ICONPICKER_COMPONENT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
