import 'package:flutter/material.dart';

import '../color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color color;
  final Color textColor;
  const RoundButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.color = AppColors.primaryButtonColor,
    this.textColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading?null:onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: loading?const Center(child: CircularProgressIndicator(color: AppColors.whiteColor,)) : Center(child: Text(title,style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 18,color: textColor),)),
      ),
    );
  }
}
