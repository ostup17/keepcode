import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepcode/features/presentation/services/cubit/services_cubit.dart';
import 'package:keepcode/features/presentation/services/cubit/services_state.dart';
import 'package:keepcode/features/widgets/my_error.dart';
import 'package:keepcode/features/widgets/my_init.dart';
import 'package:keepcode/features/widgets/my_loading.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) {
            if (state is ServicesInit) {
              return MyInit();
            } else if (state is ServicesLoading) {
              return MyLoading();
            } else if (state is ServicesLoaded) {
              return ListView.builder(
                itemCount: state.servicesModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 35,
                          child: Image.network(
                            'https://smsactivate.s3.eu-central-1.amazonaws.com/assets/ico/${state.servicesModel[index].shortName}0.webp',
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                        Text('${state.enValues[index]}'),
                        Column(
                          children: [
                            Text('Total count - ${state.servicesModel[index].totalCount}'),
                            Text('Mit price - ${state.servicesModel[index].minPrice}'),
                            Text('Mit free price - ${state.servicesModel[index].minFreePrice}')
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green
                            ),
                            child: Text('Buy', style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else if (state is ServicesError) {
              return MyError();
            }
            throw StateError('err');
          },
        ),
      )),
    );
  }
}