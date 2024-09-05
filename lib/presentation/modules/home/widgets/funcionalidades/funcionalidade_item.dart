import 'package:flutter/material.dart';

class FuncionalidadeItem extends StatelessWidget {
  const FuncionalidadeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: Colors.amber,
    );
  }
}

class CustomContainerButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CustomContainerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                size: 30,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 12,
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
