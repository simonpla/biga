import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(orgContext) {
  return AppBar(
    backgroundColor: accentColor,
    elevation: 0,
    leading: SizedBox(),
    title: SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return SizedBox(
                width: (MediaQuery.of(orgContext).size.width - 176) / 5,
                child: Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: InkWell(
                        child: starIcon,
                        radius: 9,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => null,
                      ),
                    ),
                    Spacer(),
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
