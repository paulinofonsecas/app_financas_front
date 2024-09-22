import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/registar_transacao/view/registar_transacao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

class CustomFAB extends StatefulWidget {
  const CustomFAB({super.key});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  final _key = GlobalKey<ExpandableFabState>();

  void cloused() {
    Get.find<HomePageController>().update(['geral']);
    Get.find<CarteiraPageController>().update(['geral']);
    Get.back(closeOverlays: true);
  }

  void closeFAB() {
    final state = _key.currentState;
    if (state != null) {
      debugPrint('isOpen:${state.isOpen}');
      state.toggle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.up,
      pos: ExpandableFabPos.center,
      distance: 60,
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.black.withOpacity(0.6),
        blur: 4,
      ),
      openButtonBuilder: FloatingActionButtonBuilder(
        size: 56,
        builder: (
          BuildContext context,
          void Function()? onPressed,
          Animation<double> progress,
        ) {
          return FloatingActionButton(
            onPressed: onPressed,
            child: const Icon(Icons.add),
          );
        },
      ),
      children: [
        CustomFABItem(
          title: 'Saída',
          icon: Icons.arrow_downward,
          color: Colors.red,
          onTap: () {
            closeFAB();
            Get.to(
              const RegistarTransacaoPage(
                movimentoType: 2,
              ),
            )?.then(
              (value) {
                cloused();
              },
            );
          },
        ),
        CustomFABItem(
          title: 'Entrada',
          icon: Icons.arrow_upward,
          color: Colors.green,
          onTap: () {
            closeFAB();
            Get.to(
              const RegistarTransacaoPage(
                movimentoType: 1,
              ),
            )?.then(
              (value) {
                cloused();
              },
            );
          },
        ),
        CustomFABItem(
          title: 'Objectivos',
          icon: Icons.radar,
          color: Colors.orange[700]!,
          onTap: () {},
        ),
        CustomFABItem(
          title: 'Transferências',
          icon: Icons.radar,
          color: Colors.blue[700]!,
          onTap: () {},
        ),
      ],
    );
  }
}

class CustomFABItem extends StatelessWidget {
  const CustomFABItem({
    super.key,
    this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String? title;
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (title != null) const GutterSmall(),
        FloatingActionButton.small(
          backgroundColor: color,
          heroTag: null,
          onPressed: onTap,
          child: Icon(icon),
        ),
      ],
    );
  }
}
