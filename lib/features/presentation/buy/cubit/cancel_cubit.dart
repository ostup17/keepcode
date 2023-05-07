import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/buy/cubit/cancel_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CancelCubit extends Cubit<CancelState> {
  CancelCubit() : super(CancelInit());

  Future<void> cancel(String id) async {
    emit(CancelLoading());
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken') ?? '';
    final sessionId = prefs.getString('sessionId') ?? '';

    final response = await http.get(Uri.parse(
        'https://sms-activate.org/stubs/handler_api.php?refresh_token=$refreshToken&sessionId=$sessionId&owner=6&userid=1155497&action=setStatus&id=$id&status=8'));
    if (response.statusCode == 200) {
      emit(CancelLoaded());
    } else {
      emit(CancelError());
    }
  }
}
