import 'package:app_financas/presentation/cubit/bottom_sheet_conta_cubit.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'banco_img_widget.dart';
import 'search_component.dart';

class BottomSheetContasWidget extends StatefulWidget {
  const BottomSheetContasWidget({
    Key? key,
  }) : super(key: key);

  static Future<dynamic> openModalBottomSheet(
    BuildContext context,
    BottomSheetContaCubit cubit,
    SelectContaCubit cubit2,
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
        height: size.height * 0.6,
      ),
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: cubit,
            ),
            BlocProvider.value(
              value: cubit2,
            ),
          ],
          child: const BottomSheetContasWidget(),
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
            const Gutter(),
            Expanded(
              child: BlocBuilder<BottomSheetContaCubit, BottomSheetContaState>(
                bloc: context.read<BottomSheetContaCubit>()..listContas(),
                builder: (context, state) {
                  if (state is ListarContasLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ListarContasError) {
                    return Center(
                      child: Text(state.errorMessage ??
                          'Ocorreu um erro, tente novamente'),
                    );
                  }

                  if (state is ListarContasSuccess) {
                    var selectedContaState =
                        context.read<SelectContaCubit>().state;
                    var selectedIndex = selectedContaState is SelectContaSuccess
                        ? selectedContaState.conta.id
                        : state.contas.first.id;

                    return ListView.separated(
                      itemCount: state.contas.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        indent: kDefaultPadding,
                        endIndent: kDefaultPadding,
                      ),
                      itemBuilder: (context, index) {
                        var conta = state.contas[index];

                        return _ContaListItem(
                          conta: conta,
                          isSelectedIndex: conta.id == selectedIndex,
                          onTap: () {
                            context.read<SelectContaCubit>().selectConta(conta);
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContaListItem extends StatelessWidget {
  const _ContaListItem({
    required this.conta,
    this.isSelectedIndex = false,
    this.onTap,
  });

  final Conta conta;
  final bool isSelectedIndex;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        conta.nome,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(conta.banco.acronimo ?? conta.banco.nome),
      trailing: Icon(
        isSelectedIndex
            ? FontAwesomeIcons.circleCheck
            : FontAwesomeIcons.circle,
        size: 16,
        color: isSelectedIndex
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
      ),
      leading: CircleAvatar(
        backgroundColor: conta.color,
        radius: 18,
        child: conta.banco.imgAsset != null && conta.banco.imgAsset!.isNotEmpty
            ? BancoImgCircularWidget(conta: conta)
            : const Icon(
                FontAwesomeIcons.buildingColumns,
                size: 20,
              ),
      ),
    );
  }
}
