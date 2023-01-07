import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    this.child,
    this.action,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.borderRadius = 15,
  }) : super(key: key);

  final Widget? child;
  final Function()? action;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: action,
      child: Column(
        children: [
          Container(
            width: width ?? size.width,
            height: height ?? size.height,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
