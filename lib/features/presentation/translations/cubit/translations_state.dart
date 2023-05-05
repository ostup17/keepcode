import 'package:keepcode/features/data/translations_model.dart';

abstract class TranslationsState {}

class TranslationsInit extends TranslationsState {}

class TranslationsLoading extends TranslationsState {}

class TranslationsLoaded extends TranslationsState {
  TranslationsLoaded({required this.translationsModel});
  final TranslationsModel translationsModel;
}

class TranslationsError extends TranslationsState {}
