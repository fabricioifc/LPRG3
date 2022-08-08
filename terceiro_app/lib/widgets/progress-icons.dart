import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProgressIcons extends StatelessWidget {
  final int total;
  final int done;

  const ProgressIcons({required this.total, required this.done});

  @override
  Widget build(BuildContext context) {
    final iconSize = 50.0;

    final doneIcon = Icon(
      Icons.beenhere,
      color: Colors.orange,
      size: iconSize,
    );
    final noDoneIcon = Icon(
      Icons.beenhere_outlined,
      color: Colors.orangeAccent[100],
      size: iconSize,
    );

    List<Icon> icons = [];

    for (var i = 0; i < total; i++) {
      if (i < done) {
        icons.add(doneIcon);
      } else {
        icons.add(noDoneIcon);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons,
    );
  }
}
