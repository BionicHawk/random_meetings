import 'package:flutter/material.dart';

class DescriptionItem extends StatelessWidget {
  final IconData icon;
  final Widget? child;
  final String? labelName;
  final VoidCallback? editAction;
  final bool editionEnabled;

  const DescriptionItem(
      {super.key,
      this.child,
      this.icon = Icons.abc,
      this.labelName,
      this.editAction,
      this.editionEnabled = true});

  @override
  Widget build(BuildContext context) {
    const horizontalSpacer = SizedBox(
      width: 10,
    );

    var childrenOfRow = <Widget>[
      CircleAvatar(child: Icon(icon)),
      horizontalSpacer,
      Text(
        labelName ?? "No name",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      horizontalSpacer,
    ];

    if (editionEnabled) {
      childrenOfRow
          .add(IconButton(onPressed: editAction, icon: const Icon(Icons.edit)));
    }

    final label = Row(children: childrenOfRow);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [label, child ?? const Text("No content"), const Divider()],
    );
  }
}
