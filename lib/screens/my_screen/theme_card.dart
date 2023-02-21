import 'package:flutter/material.dart';

class ThemeCard extends StatefulWidget {
  ThemeCard({required this.textColor, this.isSelected = Colors.lightBlue, required this.onTap});
  Color textColor;
  Color isSelected;
  VoidCallback onTap;

  @override
  State<ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<ThemeCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 6.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          width: MediaQuery.of(context).size.width / 2.3,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: widget.isSelected == widget.textColor? Border.all(color: widget.textColor, width: 5): null,
            borderRadius: BorderRadius.all(
               Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [widget.textColor.withOpacity(.4), widget.textColor.withOpacity(.4)],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "YOLO",
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'wheezy',
                      style: TextStyle(
                          color: widget.textColor.withOpacity(.9), fontSize: 25),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
