import 'package:app_financas/presentation/modules/carteira/components/conta_item_comp.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_conta_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/conta_details/conta_details_page.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../conta/bloc/create_conta_bloc.dart';
import '../../conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import '../../conta/cubit/reajustar_saldo_cubit.dart';

class CarteiraCardSection extends StatefulWidget {
  const CarteiraCardSection({super.key});

  @override
  State<CarteiraCardSection> createState() => _CarteiraCardSectionState();
}

class _CarteiraCardSectionState extends State<CarteiraCardSection> {
  late final CarteiraPageController carteiraController;
  late final PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    carteiraController = Get.find<CarteiraPageController>();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
      keepPage: true,
    );

    super.initState();
  }

  // TODO Melhorar a implementa;\cao deste widget
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<ContasCubit>().getContas();

    return MultiBlocListener(
      listeners: [
        BlocListener<ContaMostrarNaTelaInicialCubit,
            ContaMostrarNaTelaInicialState>(
          listener: (context, state) {
            if (state is ContaMostrarNaTelaChanged) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
        BlocListener<ReajustarSaldoCubit, ReajustarSaldoState>(
          listener: (context, state) {
            if (state is ReajustarSaldoSuccess) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
        BlocListener<CreateContaBloc, CreateContaState>(
          listener: (context, state) {
            if (state is CreateContaSuccess) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
        BlocListener<RegistarTransacaoBloc, RegistarTransacaoState>(
          listener: (context, state) {
            if (state is RegistarTransacaoSuccess) {
              context.read<ContasCubit>().getContas();
            }
          },
        ),
      ],
      child: GetBuilder(
        init: carteiraController,
        id: 'geral',
        builder: (c) {
          return SizedBox(
            height: size.height * .25,
            child: BlocBuilder<ContasCubit, ContasState>(
              bloc: context.read<ContasCubit>()..getContas(),
              buildWhen: (previous, current) =>
                  previous != current && current is ContasListarContas,
              builder: (context, state) {
                if (state is ContasListarContasLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ContasListarContasError) {
                  return Text('//${state.errorMessage}');
                }

                if (state is ContasListarContasEmpty) {
                  return const Text('Sem contas para apresentar');
                }

                if (state is ContasListarContasSuccess) {
                  var contas = state.contas;
                  var changeContas = context.read<ChangeContaCubit>();

                  if (changeContas.state is ChageContaInitial) {
                    changeContas.updateContaIndex(contas.first.id);
                  }

                  return PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      context
                          .read<ChangeContaCubit>()
                          .updateContaIndex(contas[index].id);
                      carteiraController.updateContaIndex(contas[index].id);
                      carteiraController.updateConta(contas[index]);

                      setState(() {
                        currentIndex = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: contas.length,
                    itemBuilder: (context, index) {
                      var conta = contas[index];

                      return Hero(
                        tag: 'conta_${conta.id}',
                        child: ContaItem(
                          conta: conta,
                          isActive: index == currentIndex,
                          onTap: () {
                            if (index == currentIndex) {
                              Get.to(
                                ContaDetailsPage(
                                  conta: conta,
                                ),
                              )?.then((value) {
                                setState(() {});
                                carteiraController.pagingController.refresh();
                                carteiraController.update(['geral']);
                              });
                            }
                          },
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
