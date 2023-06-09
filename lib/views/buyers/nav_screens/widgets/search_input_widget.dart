import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search Product',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                // child: SvgPicture.asset(
                //   'assets/icons/search.svg',
                //   width: 10,
                // ),
                child: Icon(Icons.search),
              )),
        ),
      ),
    );
  }
}