class ServicesModel {
  final int id;
  final String historyType;
  final String name;
  final String fieldATitle;
  final String fieldAValue;
  final String fieldBTitle;
  final String fieldBValue;
  final String shortDescription;
  final String shiftCode;
  final String description;
  final int servicesGroup;

  ServicesModel({
    this.id,
    this.historyType,
    this.name,
    this.fieldATitle,
    this.fieldAValue,
    this.fieldBTitle,
    this.fieldBValue,
    this.shortDescription,
    this.shiftCode,
    this.description,
    this.servicesGroup,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'history_type': historyType,
      'name': name,
      'field_a_title': fieldATitle,
      'field_a_value': fieldAValue,
      'field_b_title': fieldBTitle,
      'field_b_value': fieldBValue,
      'short_description': shortDescription,
      'shift_code': shiftCode,
      'description': description,
      'services_group': servicesGroup,
    };
  }

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      id: json['id'],
      historyType: json['history_type'],
      name: json['name'],
      fieldATitle: json['field_a_title'],
      fieldAValue: json['field_a_value'],
      fieldBTitle: json['field_b_title'],
      fieldBValue: json['field_b_value'],
      shortDescription: json['short_description'],
      shiftCode: json['shift_code'],
      description: json['description'],
      servicesGroup: json['services_group'],
    );
  }
}
