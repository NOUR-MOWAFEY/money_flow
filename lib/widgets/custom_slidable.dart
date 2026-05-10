import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomSlidable extends StatelessWidget {
  const CustomSlidable({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: StretchMotion(),
        extentRatio: .35,
        children: [
          SlidableAction(
            onPressed: (context) {},
            flex: 1,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            // label: 'Delete',
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: Color.fromARGB(255, 73, 188, 254),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            icon: Icons.edit_rounded,
            // label: 'Edit',
          ),
        ],
      ),

      child: child,
    );
  }
}
