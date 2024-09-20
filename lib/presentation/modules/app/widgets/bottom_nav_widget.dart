import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.index,
    required this.onTap,
  });

  final int index;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      useLegacyColorScheme: false,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.creditCard,
          ),
          label: 'Contas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.chartColumn,
          ),
          label: 'Estatisticas',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.ellipsis,
          ),
          label: 'Mais',
        ),
      ],
    );
  }
}
