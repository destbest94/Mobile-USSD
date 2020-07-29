import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_ussd/database/controllers/internet/InternetPackageController.dart';
import 'package:mobile_ussd/database/controllers/internet/InternetPackagesGroupController.dart';
import 'package:mobile_ussd/database/controllers/message/MessagePackageController.dart';
import 'package:mobile_ussd/database/controllers/message/MessagePackagesGroupController.dart';
import 'package:mobile_ussd/database/controllers/minute/MinutePackageController.dart';
import 'package:mobile_ussd/database/controllers/minute/MinutePackagesGroupController.dart';
import 'package:mobile_ussd/database/controllers/news/NewsController.dart';
import 'package:mobile_ussd/database/controllers/service/ServiceController.dart';
import 'package:mobile_ussd/database/controllers/service/ServicesGroupController.dart';
import 'package:mobile_ussd/database/controllers/tariff/TariffPlanController.dart';
import 'package:mobile_ussd/database/controllers/tariff/TariffPlansGroupController.dart';
import 'package:mobile_ussd/database/controllers/ussd/UssdCodeController.dart';
import 'package:mobile_ussd/database/controllers/ussd/UssdCodesGroupController.dart';
import 'package:mobile_ussd/database/models/internet/InternetPackageGroupModel.dart';
import 'package:mobile_ussd/database/models/internet/InternetPackageModel.dart';
import 'package:mobile_ussd/database/models/message/MessagePackageModel.dart';
import 'package:mobile_ussd/database/models/message/MessagePackagesGroupModel.dart';
import 'package:mobile_ussd/database/models/minute/MinutePackageModel.dart';
import 'package:mobile_ussd/database/models/minute/MinutePackagesGroupModel.dart';
import 'package:mobile_ussd/database/models/news/NewsModel.dart';
import 'package:mobile_ussd/database/models/service/ServicesGroupModel.dart';
import 'package:mobile_ussd/database/models/service/ServicesModel.dart';
import 'package:mobile_ussd/database/models/tariff/TariffPlanModel.dart';
import 'package:mobile_ussd/database/models/tariff/TariffPlansGroupModel.dart';
import 'package:mobile_ussd/database/models/ussd/UssdCodeModel.dart';
import 'package:mobile_ussd/database/models/ussd/UssdCodesGroupModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectToServer {
  final String _urlServer = 'http://ussduz.uz/api/';

  Future<List<dynamic>> getJson(String url, dynamic header) async {
    print(header);
    var decoded = [];
    if (await DataConnectionChecker().hasConnection) {
      print('Connected');
      var response = await http.get(_urlServer + url, headers: header);
      decoded = json.decode(utf8.decode(response.bodyBytes));
    }
    print(decoded.length);

    return decoded;
  }

  dynamic setHeader({String mobileOperator, String special}) async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language') ?? 'uz';
    final lastUpdate =
        prefs.getString(language + mobileOperator + special) ?? '';

    final header = {
      'Language': language,
    };

    if (mobileOperator.isNotEmpty) {
      header['Mobile-operator'] = mobileOperator;

      if (lastUpdate.isNotEmpty) {
        header['Last-update'] = lastUpdate;
      }
    }

    return header;
  }

  void setPref({dynamic decoded, dynamic header, String special}) async {
    final prefs = await SharedPreferences.getInstance();
    final language = header['Language'].isEmpty ? 'uz' : header['Language'];
    final mobileOperator =
        header['Mobile-operator'] == null ? '' : header['Mobile-operator'];

    if (decoded.length > 0) {
      print('#setPref');
      print(language + mobileOperator + special);
      prefs.setString(language + mobileOperator + special,
          DateTime.now().toString().substring(0, 19));
    }
  }

  //Internet---------------------------------------
  Future<List<InternetPackagesGroupModel>> getInternetPackagesGroup(
      {String mobileOperator}) async {
    final header = await setHeader(
        mobileOperator: mobileOperator, special: 'internetgroup');
    final decoded = await getJson('/internet-packages-group/', header);
    setPref(decoded: decoded, header: header, special: 'internetgroup');
    InternetPackagesGroupController model = InternetPackagesGroupController();

    List<InternetPackagesGroupModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<List<InternetPackageModel>> getInternetPackage(
      {String mobileOperator, List<String> groupsId}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'internet');

    final decoded = await getJson('/internet-package/', header);
    setPref(decoded: decoded, header: header, special: 'internet');

    InternetPackageController model = InternetPackageController();

    List<InternetPackageModel> list = await model.majorOperation(
        groupsId: groupsId, decodedJsonList: decoded);
    return list;
  }

  //Tariff---------------------------------------
  Future<List<TariffPlansGroupModel>> getTariffPlansGroup(
      {String mobileOperator}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'tariffgroup');
    final decoded = await getJson('/tariff-plans-group/', header);
    setPref(decoded: decoded, header: header, special: 'tariffgroup');

    TariffPlansGroupController model = TariffPlansGroupController();

    List<TariffPlansGroupModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<List<TariffPlanModel>> getTariffPlan(
      {String mobileOperator, List<String> groupsId}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'tariff');
    final decoded = await getJson('/tariff-plan/', header);
    setPref(decoded: decoded, header: header, special: 'tariff');
    TariffPlanController model = TariffPlanController();

    List<TariffPlanModel> list = await model.majorOperation(
        groupsId: groupsId, decodedJsonList: decoded);
    return list;
  }

  //Message---------------------------------------
  Future<List<MessagePackagesGroupModel>> getMessagePackageGroup(
      {String mobileOperator}) async {
    final header = await setHeader(
        mobileOperator: mobileOperator, special: 'messagegroup');
    final decoded = await getJson('/message-packages-group/', header);
    setPref(decoded: decoded, header: header, special: 'messagegroup');

    MessagePackagesGroupController model = MessagePackagesGroupController();

    List<MessagePackagesGroupModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<List<MessagePackageModel>> getMessagePackage(
      {String mobileOperator, List<String> groupsId}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'message');
    final decoded = await getJson('/message-package/', header);
    setPref(decoded: decoded, header: header, special: 'message');
    MessagePackageController model = MessagePackageController();

    List<MessagePackageModel> list = await model.majorOperation(
        groupsId: groupsId, decodedJsonList: decoded);
    return list;
  }

  //Minute---------------------------------------
  Future<List<MinutePackagesGroupModel>> getMinutePackageGroup(
      {String mobileOperator}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'minutegroup');
    final decoded = await getJson('/minute-packages-group/', header);
    setPref(decoded: decoded, header: header, special: 'minutegroup');

    MinutePackagesGroupController model = MinutePackagesGroupController();

    List<MinutePackagesGroupModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<List<MinutePackageModel>> getMinutePackage(
      {String mobileOperator, List<String> groupsId}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'minute');
    final decoded = await getJson('/minute-package/', header);
    setPref(decoded: decoded, header: header, special: 'minute');
    MinutePackageController model = MinutePackageController();

    List<MinutePackageModel> list = await model.majorOperation(
        groupsId: groupsId, decodedJsonList: decoded);
    return list;
  }

  //Service---------------------------------------
  Future<List<ServicesGroupModel>> getServiceGroup(
      {String mobileOperator}) async {
    final header = await setHeader(
        mobileOperator: mobileOperator, special: 'servicegroup');
    final decoded = await getJson('/services-group/', header);
    setPref(decoded: decoded, header: header, special: 'servicegroup');

    ServicesGroupController model = ServicesGroupController();

    List<ServicesGroupModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<List<ServicesModel>> getService(
      {String mobileOperator, List<String> groupsId}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'service');
    final decoded = await getJson('/service/', header);
    setPref(decoded: decoded, header: header, special: 'service');
    ServiceController model = ServiceController();

    List<ServicesModel> list = await model.majorOperation(
        groupsId: groupsId, decodedJsonList: decoded);
    return list;
  }

  //UssdCode---------------------------------------
  Future<List<UssdCodesGroupModel>> getUssdCodesGroup(
      {String mobileOperator}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'ussdgroup');
    final decoded = await getJson('/ussd-codes-group/', header);
    setPref(decoded: decoded, header: header, special: 'ussdgroup');

    UssdCodesGroupController model = UssdCodesGroupController();

    List<UssdCodesGroupModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<List<UssdCodeModel>> getUssdCode(
      {String mobileOperator, List<String> groupsId}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'ussd');
    final decoded = await getJson('/ussd-code/', header);
    setPref(decoded: decoded, header: header, special: 'ussd');
    UssdCodeController model = UssdCodeController();

    List<UssdCodeModel> list = await model.majorOperation(
        groupsId: groupsId, decodedJsonList: decoded);
    return list;
  }

  //News---------------------------------------
  Future<List<NewsModel>> getNews({String mobileOperator}) async {
    final header =
        await setHeader(mobileOperator: mobileOperator, special: 'news');

    final decoded = await getJson('/news/', header);
    setPref(decoded: decoded, header: header, special: 'news');

    NewsController model = NewsController();

    List<NewsModel> list = await model.majorOperation(
        mobileOperator: mobileOperator,
        language: header['Language'],
        decodedJsonList: decoded);
    return list;
  }

  Future<void> _downladHelper({String key, bool anyway, method}) async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language') ?? 'uz';
    String date = prefs.getString(lang + 'Mobiuz' + key) ?? '';

    if (date.isEmpty || anyway) {
      try {
        await method(mobileOperator: '');
        final String date = DateTime.now().toString().substring(0, 19);
        prefs.setString(lang + 'Mobiuz' + key, date);
        prefs.setString(lang + 'Ucell' + key, date);
        prefs.setString(lang + 'Uzmobile' + key, date);
        prefs.setString(lang + 'Beeline' + key, date);
        prefs.setString(lang + 'Perfectum' + key, date);
      } catch (e) {
        print('Error: ' + lang + key);
        print(e);
      }
    }
  }

  Future<void> downloadAll({bool anyway = false}) async {
    await _downladHelper(
        key: 'internetgroup', anyway: anyway, method: getInternetPackagesGroup);

    await _downladHelper(
        key: 'internet', anyway: anyway, method: getInternetPackage);

    await _downladHelper(
        key: 'messagegroup', anyway: anyway, method: getMessagePackageGroup);

    await _downladHelper(
        key: 'message', anyway: anyway, method: getMessagePackage);

    await _downladHelper(
        key: 'minutegroup', anyway: anyway, method: getMinutePackageGroup);

    await _downladHelper(
        key: 'minute', anyway: anyway, method: getMinutePackage);

    await _downladHelper(
        key: 'servicegroup', anyway: anyway, method: getServiceGroup);

    await _downladHelper(key: 'service', anyway: anyway, method: getService);

    await _downladHelper(
        key: 'tariffgroup', anyway: anyway, method: getTariffPlansGroup);

    await _downladHelper(key: 'tariff', anyway: anyway, method: getTariffPlan);

    await _downladHelper(
        key: 'ussdgroup', anyway: anyway, method: getUssdCodesGroup);

    await _downladHelper(key: 'ussd', anyway: anyway, method: getUssdCode);

    await _downladHelper(key: 'news', anyway: anyway, method: getNews);
  }
}
