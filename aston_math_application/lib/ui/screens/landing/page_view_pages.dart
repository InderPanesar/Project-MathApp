import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewPages {

  static List<Widget> getPages() {
    return [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Page 1", style: TextStyle(fontSize: 12),),
              Text("Description", style: TextStyle(fontSize: 12))
            ],
          )
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Page 2", style: TextStyle(fontSize: 12),),
                Text("Description", style: TextStyle(fontSize: 12))
              ],
            )
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Page 3", style: TextStyle(fontSize: 12),),
                Text("Description", style: TextStyle(fontSize: 12))
              ],
            )
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Page 4", style: TextStyle(fontSize: 12),),
                Text("Description", style: TextStyle(fontSize: 12))
              ],
            )
        ),
      ),
    ];
  }
}