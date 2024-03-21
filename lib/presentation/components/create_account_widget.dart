// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateAccountWidget extends StatelessWidget {
  const CreateAccountWidget({
    super.key,
    this.onTap,
  });

  final String title = 'Criar conta';
  final IconData icon = Icons.add;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w400),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
