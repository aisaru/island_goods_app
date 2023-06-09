import 'package:flutter/material.dart';
import 'package:island_goods/views/buyers/nav_screens/widgets/banner_widget.dart';
import 'package:island_goods/views/buyers/nav_screens/widgets/item_list_widget.dart';
import 'package:island_goods/views/buyers/nav_screens/widgets/search_input_widget.dart';
import 'package:island_goods/views/buyers/nav_screens/widgets/welcome_text_widget.dart';

class Homescreen extends StatelessWidget {
  Homescreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WelcomeText(),
        SizedBox(height: 14),
        SearchInputWidget(),
        BannerWidget(),
        SizedBox(height: 14),
        Expanded(
          child: ItemListWidget(),
        ),
      ],
    );
  }
}
