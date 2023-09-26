import 'package:flutter/material.dart';

class SectionConf extends StatelessWidget {
  final double height;
  final String sectionName;

  const SectionConf(
      {super.key, this.height = 43, this.sectionName = "No Name"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Row(
            children: [
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Text(
                sectionName,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
