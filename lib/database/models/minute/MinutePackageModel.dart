class MinutePackageModel {
  final int id;
  final String historyType;
  final String name;
  final String fieldATitle;
  final String fieldAValue;
  final String fieldBTitle;
  final String fieldBValue;
  final String fieldCTitle;
  final String fieldCValue;
  final String fieldDTitle;
  final String fieldDValue;
  final String fieldETitle;
  final String fieldEValue;
  final String shiftCode;
  final String description;
  final int minutePackagesGroup;

  MinutePackageModel({
    this.id,
    this.historyType,
    this.name,
    this.fieldATitle,
    this.fieldAValue,
    this.fieldBTitle,
    this.fieldBValue,
    this.fieldCTitle,
    this.fieldCValue,
    this.fieldDTitle,
    this.fieldDValue,
    this.fieldETitle,
    this.fieldEValue,
    this.shiftCode,
    this.description,
    this.minutePackagesGroup,
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
      'field_c_title': fieldCTitle,
      'field_c_value': fieldCValue,
      'field_d_title': fieldDTitle,
      'field_d_value': fieldDValue,
      'field_e_title': fieldETitle,
      'field_e_value': fieldEValue,
      'shift_code': shiftCode,
      'description': description,
      'minute_packages_group': minutePackagesGroup,
    };
  }

  factory MinutePackageModel.fromJson(Map<String, dynamic> json) {
    return MinutePackageModel(
      id: json['id'],
      historyType: json['history_type'],
      name: json['name'],
      fieldATitle: json['field_a_title'],
      fieldAValue: json['field_a_value'],
      fieldBTitle: json['field_b_title'],
      fieldBValue: json['field_b_value'],
      fieldCTitle: json['field_c_title'],
      fieldCValue: json['field_c_value'],
      fieldDTitle: json['field_d_title'],
      fieldDValue: json['field_d_value'],
      fieldETitle: json['field_e_title'],
      fieldEValue: json['field_e_value'],
      shiftCode: json['shift_code'],
      description: json['description'],
      minutePackagesGroup: json['minute_packages_group'],
    );
  }
}
