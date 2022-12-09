import 'package:avenique/src/features/category/data/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/category.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key});

  static Route<Category?> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => SelectCategoryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryRepository = RepositoryProvider.of<CategoryRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: StreamBuilder(
        stream: categoryRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;

            return ListView.separated(
              itemCount: categories.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(categories[index].name),
                onTap: () => Navigator.of(context).pop(categories[index]),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 8,),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}