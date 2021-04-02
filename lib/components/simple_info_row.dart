import 'package:flutter/material.dart';

class SimpleInfoRow extends StatelessWidget {
  final String title;
  final String info;

  SimpleInfoRow({this.info, this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey),
        ),
        Text(info),
      ],
    );
  }
}
