import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/core/constant/padding.dart';
import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/providers/articles/article_model.dart';
import 'package:teba_haber_v2/providers/articles/data_manager.dart';
import 'package:teba_haber_v2/widgets/card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CacheManger {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkAuthenticate();
  }

  Future<void> checkAuthenticate() async {
    bool? token = await hasToken();
    isAuthenticated = token;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // get provider base
    IDataManager iData = Provider.of<IDataManager>(context);
    // get provider watch list
    List<ArticleModel> articles = iData.articles;
    bool isLoading = iData.listGetLoading;
    return PopScope(
      canPop: false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          removeToken();
        }),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            title: const Text("Teba Haber"),
            actions: [authController()]),
        body: Padding(
          padding: PaddingConstant.pageContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Güncel Haberler",
                  style: textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: !isLoading
                    // list view Articles
                    ? ListView.separated(
                        separatorBuilder: (c, i) => const SizedBox(height: 30),
                        itemCount: articles.length,
                        itemBuilder: (context, index) => CardListItem(
                          article: articles[index],
                        ),
                      )
                    :
                    // loading indicator
                    const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton authController() {
    if (isAuthenticated) {
      // open drawer
      return IconButton(
          onPressed: () {}, icon: const Icon(Icons.menu_open_outlined));
    } else {
      return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        icon: const Icon(Icons.key),
      );
    }
  }
}
