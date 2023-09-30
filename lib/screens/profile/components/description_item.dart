import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  final IconData icon;
  final Widget? child;
  final String? labelName;
  final VoidCallback? editAction;
  const DescriptionItem(
      {super.key,
      this.child,
      this.icon = Icons.abc,
      this.labelName,
      this.editAction});

  @override
  Widget build(BuildContext context) {
    const horizontalSpacer = SizedBox(
      width: 10,
    );
    final label = Row(
      children: [
        CircleAvatar(child: Icon(icon)),
        horizontalSpacer,
        Text(
          labelName ?? "No name",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        horizontalSpacer,
        IconButton(onPressed: editAction, icon: const Icon(Icons.edit))
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [label, child ?? const Text("No content"), const Divider()],
    );
  }
}
