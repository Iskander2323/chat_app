import 'package:chat_app/components/custom/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontSize,
  });

  final String text;
  final double? fontSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.primary,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: fontSize ?? 16),
          ),
        ),
      ),
    );
  }
}
