import 'package:flutter/material.dart';

class CategoriesItem extends StatefulWidget {
  const CategoriesItem(
      {super.key, required this.categories, this.light = false});
  final List<String>? categories;
  final bool light;
  @override
  State<CategoriesItem> createState() => _CategoriesItemState();
}

class _CategoriesItemState extends State<CategoriesItem> {
  @override
  Widget build(BuildContext context) {
    List<String>? item = widget.categories;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 18,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, inx) => Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: widget.light ? Colors.white : Colors.red,
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    item[inx],
                    style: textTheme.bodySmall?.copyWith(
                      color: widget.light ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ),
          separatorBuilder: (ctx, inx) => const SizedBox(width: 8),
          itemCount: item!.length),
    );
  }
}
