import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_cubit.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_state.dart';
import 'package:keepcode/features/widgets/my_error.dart';
import 'package:keepcode/features/widgets/my_init.dart';
import 'package:keepcode/features/widgets/my_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/presentation/buy/buy.dart';

class CheckSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BuyCubit, BuyState>(
          builder: (context, state) {
            if (state is BuyInit) {
              return MyInit();
            } else if (state is BuyLoading) {
              return MyLoading();
            } else if (state is BuyLoaded) {
              return Buy();
            } else if (state is BuyError) {
              return Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final id = await prefs.getString('id');
                    await context
                        .read<BuyCubit>()
                        .getInfoBuy(id!)
                        .whenComplete(() => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Buy()),
                            ));
                  },
                  child: Text('Confirm'),
                ),
              );
            }
            throw StateError('err');
          },
        ),
      ),
    );
  }
}
