import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_cubit.dart';
import 'package:keepcode/features/presentation/buy/cubit/buy_state.dart';
import 'package:keepcode/features/presentation/buy/cubit/cancel_cubit.dart';
import 'package:keepcode/features/presentation/services/services.dart';
import 'package:keepcode/features/widgets/my_error.dart';
import 'package:keepcode/features/widgets/my_init.dart';
import 'package:keepcode/features/widgets/my_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buy extends StatelessWidget {
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
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.activation.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.activation[index]),
                          InkWell(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await context
                                  .read<CancelCubit>()
                                  .cancel(state.activation[index])
                                  .whenComplete(() {
                                state.activation.removeAt(index);
                                prefs
                                    .setStringList(
                                        'activation', state.activation)
                                    .whenComplete(() => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Buy()),
                                        ));
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.red),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Services()),
                      );
                    },
                    child: Text('Back'))
              ],
            );
          } else if (state is BuyError) {
            return Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.buyErrorModel.error, textAlign: TextAlign.center,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Services()),
                      );
                    },
                    child: Text('Вернуться'))
              ],
            )
            );
          } else if (state is BuyNumberIsBusy) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'There are currently no available rooms, please select another service',
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back'))
                ],
              ),
            );
          }
          throw StateError('err');
        },
      )),
    );
  }
}
