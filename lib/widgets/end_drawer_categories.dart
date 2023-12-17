import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teba_haber_v2/core/network/cache_manager.dart';
import 'package:teba_haber_v2/providers/articles/data_manager.dart';
import 'package:teba_haber_v2/providers/auth/auth_manager.dart';
import 'package:teba_haber_v2/providers/auth/user_available_category_model.dart';

class CategoriesDrawerWidget extends StatefulWidget {
  const CategoriesDrawerWidget({super.key});

  @override
  State<CategoriesDrawerWidget> createState() => _CategoriesDrawerWidgetState();
}

class _CategoriesDrawerWidgetState extends State<CategoriesDrawerWidget>
    with CacheManger {
  GlobalKey<DrawerControllerState> draweRef = GlobalKey();

  @override
  Widget build(BuildContext context) {
    IAuthManager authManager = Provider.of<IAuthManager>(context);
    IDataManager dataManager = Provider.of<IDataManager>(context);
    // get list
    List<AvailableCategoryModel> categories =
        authManager.userAvailableCategories;
    // render
    return Drawer(
      key: draweRef,
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      width: 250,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    dataManager.getArticles(categories[index].value);
                    Navigator.pop(context);
                  },
                  title: Text(
                    categories[index].text,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              authManager.changeAuth();
            },
            child: const Text('Oturumu kapat'),
          ),
        ],
      ),
    );
  }
}
