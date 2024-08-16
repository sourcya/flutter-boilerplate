/// _id : "615ba74c2994816bb3a68"
/// name : "Authenticated"
/// description : "Default role given to authenticated user."
/// type : "authenticated"
/// __v : 0
library;

class Role {
  String? id;
  String? name;
  String? description;
  String? type;
  int? v;

  Role({
    this.id,
    this.name,
    this.description,
    this.type,
    this.v,
  });

  Role.fromJson(dynamic json) {
    id = json['_id'] as String?;
    name = json['name'] as String?;
    description = json['description'] as String?;
    type = json['type'] as String?;
    v = json['__v'] as int?;
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['type'] = type;
    map['__v'] = v;
    return map;
  }
}
