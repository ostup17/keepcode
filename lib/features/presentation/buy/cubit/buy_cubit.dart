import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/data/models/buy_error_mode.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/buy_model.dart';

class BuyCubit extends Cubit<BuyState> {
  BuyCubit() : super(BuyInit());

  Future<void> auth() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(
        'https://sms-activate.org/stubs/handler_auth.php?owner=6&email=adwtrafanet@yandex.ru&code=111111&action=confirmEmailByCode'));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body) as Map<String, dynamic>;
      await prefs.setString(
          'refreshToken', responseJson['refresh_token'.toString()]);
      await prefs.setString('sessionId', responseJson['sessionId'].toString());
      print('12312');
    }
  }

  Future<void> getInfoBuy(String service) async {
    emit(BuyLoading());
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken') ?? '';
    final sessionId = prefs.getString('sessionId') ?? '';

    final response = await http.get(Uri.parse(
        'https://sms-activate.org/stubs/handler_api.php?refresh_token=$refreshToken&sessionId=$sessionId&owner=6&userid=1398357&country=0&service=$service&action=getNumberMobile&forward=0&operator=any'));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body) as Map<String, dynamic>;
      print("Buy cubit $responseJson");
      if (responseJson.containsKey('error')) {
        auth();
        if (responseJson['error'] == 'NO_NUMBERS') {
          print(responseJson['error']);
          emit(BuyNumberIsBusy());
        }
        emit(BuyError(buyErrorModel: BuyErrorModel.fromJson(responseJson)));
      } else {
        final List<String> activation = prefs.getStringList('activation') ?? [];
        activation.add(responseJson['activation']);
        prefs.setStringList('activation', activation);

        emit(BuyLoaded(
            buyModel: BuyModel.fromJson(responseJson), activation: activation));
      }
    }
  }
}
