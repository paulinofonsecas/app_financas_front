// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/components/banco_img_widget.dart';
import 'package:app_financas/presentation/components/bottom_sheet_contas.dart';
import 'package:app_financas/presentation/cubit/bottom_sheet_conta_cubit.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContaListItemComponent extends StatelessWidget {
  const ContaListItemComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContaListItemView();
  }
}

class ContaListItemView extends StatelessWidget {
  const ContaListItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BottomSheetContasWidget.openModalBottomSheet(
          context,
          context.read<BottomSheetContaCubit>(),
          context.read<SelectContaCubit>(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            BlocBuilder<SelectContaCubit, SelectContaState>(
              bloc: context.read<SelectContaCubit>()..selectDefaultConta(),
              builder: (context, state) {
                if (state is SelectContaLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SelectContaError) {
                  return Text('//${state.errorMessage}');
                }

                if (state is SelectContaSuccess) {
                  return _ShowContaWidget(conta: state.conta);
                }

                return const SizedBox();
              },
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _ShowContaWidget extends StatelessWidget {
  const _ShowContaWidget({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding / 2,
        vertical: kDefaultPadding / 3,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        border: Border.all(
          color: conta.color,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          conta.banco.imgAsset != null && conta.banco.imgAsset!.isNotEmpty
              ? BancoImgCircularWidget(conta: conta)
              : const Icon(
                  FontAwesomeIcons.buildingColumns,
                  size: 18,
                ),
          const GutterSmall(),
          Text(conta.nome),
        ],
      ),
    );
  }
}
