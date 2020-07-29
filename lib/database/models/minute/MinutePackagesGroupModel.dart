class MinutePackagesGroupModel {
  final int id;
  final String historyType;
  final String name;
  final String mobileOperator;
  final String language;

  MinutePackagesGroupModel({this.id, this.historyType, this.name, this.mobileOperator, this.language});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'history_type': historyType,
      'name': name,
      'mobile_operator': mobileOperator,
      'language': language,
    };
  }

  factory MinutePackagesGroupModel.fromJson(Map<String, dynamic> json) {
    return MinutePackagesGroupModel(
      id: json['id'],
      historyType: json['history_type'],
      name: json['name'],
      mobileOperator: json['mobile_operator'],
      language: json['language'],
    );
  }
}