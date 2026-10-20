import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class TopicSelector extends StatelessWidget {
  const TopicSelector({
    required this.topics,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<String> topics;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: topics.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final topic = topics[index];
          final isSelected = topic.toLowerCase() == selected.toLowerCase();
          return ChoiceChip(
            selected: isSelected,
            onSelected: (_) => onSelected(topic),
            label: Text(topic),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppColors.ink,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: AppColors.ink,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFE4E0D8)),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
