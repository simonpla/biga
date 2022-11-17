import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(orgContext) {
  return AppBar(
    //backgroundColor: accentColor,
    elevation: 0, // no shadow
    leading: Container(),
    titleSpacing: 0, // remove space between title and leading
    title: SizedBox(
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(orgContext).size.width - 112,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              itemCount: (MediaQuery.of(orgContext).size.width - 112) ~/ 100,
              itemBuilder: (context, index) {
                print(
                    '${MediaQuery.of(orgContext).size.width - 112} ${(MediaQuery.of(orgContext).size.width - 112) ~/ 100}');

                return SizedBox(
                  width: (MediaQuery.of(orgContext).size.width - 112) /
                      ((MediaQuery.of(orgContext).size.width - 112) ~/
                          100), // 56 is size of leading
                  child: Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          // color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Ink(
                          decoration: ShapeDecoration(
                              color: Theme.of(context).iconTheme.color,
                              shape: CircleBorder()),
                          child: IconButton(
                            icon: starIcon,
                            //color: Colors.deepOrangeAccent[400],
                            //hoverColor: Colors.transparent,
                            //highlightColor: Colors.transparent,
                            onPressed: () => null,
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 56),
        ],
      ),
    ),
  );
}
