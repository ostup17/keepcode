import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/translations/cubit/translations_cubit.dart';
import 'package:keepcode/features/presentation/translations/cubit/translations_state.dart';
import 'package:keepcode/features/widgets/my_error.dart';
import 'package:keepcode/features/widgets/my_init.dart';
import 'package:keepcode/features/widgets/my_loading.dart';

class Translations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<TranslationsCubit, TranslationsState>(
        builder: (context, state) {
          if (state is TranslationsInit) {
            return MyInit();
          } else if (state is TranslationsLoading) {
            return MyLoading();
          } else if (state is TranslationsLoaded) {
            return Center(
              child: Text("Successful"),
            );
          } else if (state is TranslationsError) {
            return MyError();
          }
          throw StateError('err');
        },
      )),
    );
  }
}
