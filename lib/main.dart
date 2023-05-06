import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/services/cubit/services_cubit.dart';
import 'package:keepcode/features/presentation/translations/cubit/translations_cubit.dart';
import 'package:keepcode/features/presentation/translations/translations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TranslationsCubit>(
            create: (context) => TranslationsCubit()..getAllTranslations(),
        ),
        BlocProvider<ServicesCubit>(
            create: (context) => ServicesCubit()..getAllServices(),
        ),
      ],
       child: MaterialApp(
        home: Translations()
       )
       );
  }
}
