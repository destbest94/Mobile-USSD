import 'package:sqflite/sqflite.dart';

void createTables(Database db) async {
  Batch batch = db.batch();
  batch.execute('CREATE TABLE internet_packages_group(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'mobile_operator TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE internet_package (' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'subscription_fee TEXT, ' +
      'mobile_internet_amount TEXT, ' +
      'validity_period TEXT, ' +
      'shift_code TEXT, ' +
      'description TEXT, ' +
      'internet_packages_group INTEGER)');

  batch.execute('CREATE TABLE tariff_plans_group(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'mobile_operator TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE tariff_plan (' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'subscription_fee_title TEXT, ' +
      'subscription_fee TEXT, ' +
      'mobile_internet_title TEXT, ' +
      'mobile_internet_amount TEXT, ' +
      'minute_title TEXT, ' +
      'minute_amount TEXT, ' +
      'message_title TEXT, ' +
      'message_amount TEXT, ' +
      'shift_code TEXT, ' +
      'description TEXT, ' +
      'tariff_plans_group INTEGER)');

  batch.execute('CREATE TABLE message_packages_group(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'mobile_operator TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE message_package (' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'field_a_title TEXT, ' +
      'field_a_value TEXT, ' +
      'field_b_title TEXT, ' +
      'field_b_value TEXT, ' +
      'field_c_title TEXT, ' +
      'field_c_value TEXT, ' +
      'field_d_title TEXT, ' +
      'field_d_value TEXT, ' +
      'field_e_title TEXT, ' +
      'field_e_value TEXT, ' +
      'shift_code TEXT, ' +
      'description TEXT, ' +
      'message_packages_group INTEGER)');

  batch.execute('CREATE TABLE minute_packages_group(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'mobile_operator TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE minute_package (' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'field_a_title TEXT, ' +
      'field_a_value TEXT, ' +
      'field_b_title TEXT, ' +
      'field_b_value TEXT, ' +
      'field_c_title TEXT, ' +
      'field_c_value TEXT, ' +
      'field_d_title TEXT, ' +
      'field_d_value TEXT, ' +
      'field_e_title TEXT, ' +
      'field_e_value TEXT, ' +
      'shift_code TEXT, ' +
      'description TEXT, ' +
      'minute_packages_group INTEGER)');

  batch.execute('CREATE TABLE news(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'title TEXT, ' +
      'mobile_operator TEXT, ' +
      'short_text TEXT, ' +
      'full_text TEXT, ' +
      'date TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE services_group(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'mobile_operator TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE service (' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'field_a_title TEXT, ' +
      'field_a_value TEXT, ' +
      'field_b_title TEXT, ' +
      'field_b_value TEXT, ' +
      'short_description TEXT, ' +
      'shift_code TEXT, ' +
      'description TEXT, ' +
      'services_group INTEGER)');

  batch.execute('CREATE TABLE ussd_codes_group(' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'mobile_operator TEXT, ' +
      'language TEXT)');

  batch.execute('CREATE TABLE ussd_code (' +
      'id INTEGER PRIMARY KEY, ' +
      'history_type TEXT, ' +
      'name TEXT, ' +
      'field_a_title TEXT, ' +
      'field_a_value TEXT, ' +
      'field_b_title TEXT, ' +
      'field_b_value TEXT, ' +
      'short_description TEXT, ' +
      'shift_code TEXT, ' +
      'description TEXT, ' +
      'ussd_codes_group INTEGER)');

  await batch.commit();
}
