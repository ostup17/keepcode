import 'package:keepcode/features/data/models/services_model.dart';

abstract class ServicesState {}

class ServicesInit extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  ServicesLoaded({required this.servicesModel});
  final List<ServicesModel> servicesModel;
}

class ServicesError extends ServicesState {}
