import 'package:flutter/material.dart';
import 'package:teba_haber_v2/providers/articles/article_model.dart';
import 'package:teba_haber_v2/widgets/categories_item.dart';
import 'package:teba_haber_v2/widgets/images/network_image_widget.dart';

class CardListItem extends StatefulWidget {
  const CardListItem({super.key, required this.article});

  final ArticleModel article;

  @override
  State<CardListItem> createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    ArticleModel item = widget.article;
    return GestureDetector(
      onTap: () {
        // go push Artile page pass id params
        Navigator.pushNamed(context, '/article', arguments: {"article": item});
      },
      child: Card(
        elevation: 0.8,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item.image != null && item.image!.isNotEmpty
                ? cardImageWidget(item)
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                runSpacing: 10,
                children: [
                  cardDateWidget(item, textTheme),
                  cardTitleWidget(item, textTheme),
                  const Divider(
                    thickness: 0.2,
                    height: 2,
                  ),
                  cardSubtitleWidget(item, textTheme),
                  CategoriesItem(categories: item.categories)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Align cardDateWidget(ArticleModel item, TextTheme textTheme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        item.date!,
        maxLines: 1,
        style: textTheme.labelSmall?.copyWith(fontSize: 10),
      ),
    );
  }

  Text cardSubtitleWidget(ArticleModel item, TextTheme textTheme) {
    return Text(
      item.subtitle!,
      maxLines: 2,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodySmall,
    );
  }

  Text cardTitleWidget(ArticleModel item, TextTheme textTheme) {
    return Text(
      item.title!,
      maxLines: 2,
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Hero cardImageWidget(ArticleModel item) {
    return Hero(
      tag: 'hero_image_${item.id}',
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(10)),
        child: ImageNetworkWidget(
          imagePath: item.image!,
          height: 100,
        ),
      ),
    );
  }
}
