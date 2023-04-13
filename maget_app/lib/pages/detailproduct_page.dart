import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/Salad.jpg',
          fit: BoxFit.cover,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.share,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
