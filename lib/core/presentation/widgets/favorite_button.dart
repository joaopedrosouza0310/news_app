import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    required this.selected,
    required this.onPressed,
    this.onDark = false,
    super.key,
  });

  final bool selected;
  final VoidCallback onPressed;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: selected ? 'Remove from saved' : 'Save story',
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: onDark ? Colors.black38 : const Color(0xFFF5F2EB),
      ),
      icon: Icon(
        selected ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        color: selected
            ? AppColors.accent
            : (onDark ? Colors.white : AppColors.muted),
      ),
    );
  }
}
