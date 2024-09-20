import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/create_objectivo/view/create_objectivo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class PreCreateObjModel {
  final String title;
  final Color color;
  final IconData icon;

  PreCreateObjModel({
    required this.title,
    required this.color,
    required this.icon,
  });
}

class PreCreateObjectivo extends StatelessWidget {
  const PreCreateObjectivo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final preObj = [
      PreCreateObjModel(
        title: 'Novo',
        color: Colors.grey,
        icon: Icons.add,
      ),
      PreCreateObjModel(
        title: 'Criar fundo de emergência',
        color: Colors.green,
        icon: Icons.savings,
      ),
      PreCreateObjModel(
        title: 'Economizar para uma viagem',
        color: Colors.blue,
        icon: Icons.airplane_ticket,
      ),
      PreCreateObjModel(
        title: 'Aposentadoria antecipada',
        color: Colors.purple,
        icon: Icons.trending_up,
      ),
      PreCreateObjModel(
        title: 'Comprar uma casa',
        color: Colors.orange,
        icon: Icons.home,
      ),
      PreCreateObjModel(
        title: 'Comprar um carro',
        color: Colors.cyan,
        icon: Icons.directions_car,
      ),
      PreCreateObjModel(
        title: 'Reforma da casa',
        color: Colors.brown,
        icon: Icons.build,
      ),
      PreCreateObjModel(
        title: 'Reservar para lazer',
        color: Colors.lightBlue,
        icon: Icons.beach_access,
      ),
      PreCreateObjModel(
        title: 'Criar reserva para saúde',
        color: Colors.pink,
        icon: Icons.local_hospital,
      ),
      PreCreateObjModel(
        title: 'Economizar para um casamento',
        color: Colors.deepOrange,
        icon: Icons.favorite,
      ),
      PreCreateObjModel(
        title: 'Poupar para educação continuada',
        color: Colors.deepPurple,
        icon: Icons.menu_book,
      ),
      PreCreateObjModel(
        title: 'Criar fundo para filhos',
        color: Colors.lime,
        icon: Icons.child_care,
      ),
    ];

    return Container(
      width: size.width,
      height: size.height * 0.8,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gutter(),
              const Text(
                'Novo objectivo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gutter(),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                children: List.generate(
                  preObj.length,
                  (index) => SampleNewCategoriaItem(
                    obj: preObj[index],
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(CreateObjectivoPage.route(
                        preObjectivo: index == 0 ? null : preObj[index],
                      ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SampleNewCategoriaItem extends StatelessWidget {
  const SampleNewCategoriaItem({
    super.key,
    required this.obj,
    required this.onTap,
  });

  final PreCreateObjModel obj;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: obj.color,
                radius: 25,
                child: Center(
                  child: Icon(
                    obj.icon,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              const GutterSmall(),
              Text(
                obj.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
