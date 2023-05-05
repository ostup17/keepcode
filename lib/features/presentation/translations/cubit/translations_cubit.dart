import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/data/translations_model.dart';
import 'package:keepcode/features/presentation/translations/cubit/translations_state.dart';
import 'package:http/http.dart' as http;

class TranslationsCubit extends Cubit<TranslationsState> {
  TranslationsCubit() : super(TranslationsInit());

  Future<void> getAllTranslations() async {
    emit(TranslationsLoading());

    final response = await http.get(Uri.parse(
        'https://sms-activate.org/stubs/apiMobile.php?owner=6&action=getAllServicesAndAllCountries'));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body) as Map<String, dynamic>;
      emit(TranslationsLoaded(
          translationsModel: TranslationsModel.fromJson(responseJson)));
    } else {
      emit(TranslationsError());
    }
  }
}
