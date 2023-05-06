import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_cubit.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_state.dart';
import 'package:keepcode/features/widgets/my_error.dart';
import 'package:keepcode/features/widgets/my_init.dart';
import 'package:keepcode/features/widgets/my_loading.dart';

class Buy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<BuyCubit, BuyState>(
        builder: (context, state) {
          if (state is BuyInit) {
            return MyInit();
          } else if (state is BuyLoading) {
            return MyLoading();
          } else if (state is BuyLoaded) {
            return Center(child: Text('succesfull'));
          } else if (state is BuyError) {
            return MyError();
          }
            throw StateError('err');
        },
      )),
    );
  }
}
