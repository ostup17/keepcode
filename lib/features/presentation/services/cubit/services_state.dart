import 'package:keepcode/features/data/services_model.dart';

abstract class ServicesState {}

class ServicesInit extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  ServicesLoaded({required this.servicesModel, required this.enValues});
  final List<ServicesModel> servicesModel;
  final List<String> enValues;
}

class ServicesError extends ServicesState {}
