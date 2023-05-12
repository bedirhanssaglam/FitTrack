import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../base/singleton/base_singleton.dart';
import '../text/custom_text.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final double? width;
  final double? height;
  final double? radius;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? pathColor;
  final IconData? icon;
  final String? pathFirst;
  final Color? pathFirstColor;
  final double? fontSize;
  final Color? textColor;
  final bool? isBold;
  final bool? isCircleButton;
  final FontWeight? fontWeight;
  final double? iconSize;
  final bool? isTherePadding;
  final double? width2;
  final String? path;
  final bool? isGradient;
  final bool? isBorder;
  final Color? firstGradient;
  final Color? secondGradient;
  final bool? isFirstIcon;
  final bool? isMain;

  const CustomButton({
    Key? key,
    this.text = "",
    this.width = 90,
    this.width2 = 1,
    this.height = 7,
    required this.onTap,
    this.radius = 15,
    this.path,
    this.iconColor = Colors.white,
    this.pathColor,
    this.icon,
    this.pathFirst,
    this.fontSize = 12,
    this.textColor = Colors.white,
    this.pathFirstColor,
    this.isBold = true,
    this.fontWeight = FontWeight.w600,
    this.iconSize = 0.025,
    this.isTherePadding = true,
    this.isGradient = true,
    this.isCircleButton = false,
    this.isBorder = false,
    this.firstGradient,
    this.secondGradient,
    this.isFirstIcon = true,
    this.isMain = true,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin, BaseSingleton {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onTap,
      child: Transform.scale(
        scale: _scale,
        child: Padding(
          padding: EdgeInsets.all(widget.isTherePadding == true ? 9 : 0),
          child: Container(
            height: widget.height?.h,
            width: widget.width?.w,
            decoration: BoxDecoration(
              color: colors.mainColor,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.white12,
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.circular(widget.radius!),
            ),
            child: Center(
              child: CustomText(
                widget.text!,
                textStyle: TextStyle(
                  color: widget.textColor,
                  fontWeight: widget.fontWeight,
                  fontSize: widget.fontSize?.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
