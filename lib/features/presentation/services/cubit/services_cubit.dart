import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/data/services_model.dart';
import 'package:keepcode/features/presentation/services/cubit/services_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInit());

  Future<void> getAllServices() async {
    emit(ServicesLoading());

    final response = await http.get(Uri.parse(
        'https://sms-activate.org/stubs/apiMobile.php?owner=6&action=getAllServices'));

    if (response.statusCode == 200) {
      final responseJson = (json.decode(response.body) as List)
          .map((e) => ServicesModel.fromJson(e))
          .toList();
      final prefs = await SharedPreferences.getInstance();
      final loadedEnValues = prefs.getStringList('enValues') ?? [];
      emit(ServicesLoaded(servicesModel: responseJson, enValues: loadedEnValues ));
    } else {
      emit(ServicesError());
    }
  }
}
