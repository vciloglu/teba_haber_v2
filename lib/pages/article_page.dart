import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:teba_haber_v2/core/constant/padding.dart';
import 'package:teba_haber_v2/providers/articles/article_model.dart';
import 'package:teba_haber_v2/widgets/categories_item.dart';
import 'package:teba_haber_v2/widgets/images/network_image_widget.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key, required this.article});

  final ArticleModel article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    ArticleModel article = widget.article;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
      ),
      body: Column(
        children: [
          article.image != null && article.image!.isNotEmpty
              ? Hero(
                  tag: 'hero_image_${article.id}',
                  child: ImageNetworkWidget(
                    imagePath: article.image!,
                    height: 175,
                  ),
                )
              : Container(
                  color: Colors.red,
                  height: 85,
                ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.red,
                    child: Padding(
                      padding: PaddingConstant.pageContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article.date!,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: CategoriesItem(
                                categories: article.categories, light: true),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              article.title!,
                              style: textTheme.titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: PaddingConstant.pageContainer,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          article.subtitle!,
                          textAlign: TextAlign.justify,
                          style: textTheme.titleSmall,
                        ),
                      ),
                      HtmlWidget(article.body!)
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
