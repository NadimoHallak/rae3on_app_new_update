import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt config = GetIt.instance;

setup() async {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  config.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );

  config.registerSingleton<GlobalKey<FormState>>(globalKey);
}
