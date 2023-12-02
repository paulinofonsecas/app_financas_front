// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/bottom_sheet_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'search_component.dart';

class BottomSheetContasWidget extends StatefulWidget {
  const BottomSheetContasWidget({
    Key? key,
  }) : super(key: key);

  static Future<dynamic> openModalBottomSheet(
    BuildContext context,
    BottomSheetContaCubit cubit,
  ) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: true,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: BottomSheetContasWidget(),
        );
      },
    );
  }

  @override
  State<BottomSheetContasWidget> createState() => _BottomSheetContaWidget();
}

class _BottomSheetContaWidget extends State<BottomSheetContasWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            SearchComponent(
              textController: TextEditingController(),
              onClearTap: () {},
            ),
            Gutter(),
            Expanded(
              child: BlocBuilder<BottomSheetContaCubit, BottomSheetContaState>(
                bloc: context.read<BottomSheetContaCubit>()..listContas(),
                builder: (context, state) {
                  return ListView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
