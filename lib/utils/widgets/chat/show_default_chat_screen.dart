import 'package:flutter/material.dart';

class ShowDefaultScreen extends StatelessWidget {
  const ShowDefaultScreen({super.key, this.margin = 0});
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: margin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.message,
            size: 100,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Select a chat to start messaging",
            style: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 20),
          ),
        ],
      ),
    );
  }
}
