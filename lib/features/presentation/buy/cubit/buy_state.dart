import 'package:keepcode/features/data/buy_auth_model.dart';
import 'package:keepcode/features/data/buy_model.dart';

abstract class BuyState {}

class BuyInit extends BuyState {}

class BuyLoading extends BuyState {}

class BuyNotAuth extends BuyState {
  BuyNotAuth({required this.buyAuthModel});
  final BuyAuthModel buyAuthModel;
}

class BuyLoaded extends BuyState {
  BuyLoaded({required this.buyModel});
  final BuyModel buyModel;
}

class BuyError extends BuyState {}
