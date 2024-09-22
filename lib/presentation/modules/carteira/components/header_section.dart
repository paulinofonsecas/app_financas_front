import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/archived_accounts/view/archived_accounts_page.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contas',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => const ArchivedAccountsPage(),
                    ),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.boxArchive,
                  size: 18,
                ),
              ),
              const GutterSmall(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(ContaPage.route());
                },
                icon: const Icon(
                  FontAwesomeIcons.gear,
                  size: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
