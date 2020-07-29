class NewsModel {
  final int id;
  final String historyType;
  final String title;
  final String mobileOperator;
  final String language;
  final String short;
  final String full;
  final String date;

  NewsModel({
    this.id,
    this.historyType,
    this.title,
    this.mobileOperator,
    this.language,
    this.short,
    this.full,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'history_type': historyType,
      'title': title,
      'mobile_operator': mobileOperator,
      'language': language,
      'short_text': short,
      'full_text': full,
      'date': date,
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      historyType: json['history_type'],
      title: json['title'],
      mobileOperator: json['mobile_operator'],
      language: json['language'],
      short: json['short_text'],
      full: json['full_text'],
      date: json['date'],
    );
  }
}
