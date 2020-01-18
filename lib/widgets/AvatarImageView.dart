import 'package:flutter/material.dart';
import 'dart:math';

class AvatarImageView extends StatelessWidget {
  final String name;
  final String photoUrl;
  final Color color;
  final int letterCount;

  AvatarImageView({
    this.name,
    this.photoUrl,
    this.color = Colors.white,
    this.letterCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _pickColors();

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(7.0)),
      child: Container(
        color: colors[0],
        child: _buildContent(colors[1]),
      ),
    );
  }

  _pickColors() {
    var colors = [
      [Color(0xff6292e6), Color(0xffffffff)],
      [Color(0xffff8484), Color(0xffffffff)],
      [Color(0xfff5a623), Color(0xffffffff)],
      [Color(0xff99bdfb), Color(0xffffffff)],
    ];

    final rand = Random(name.hashCode).nextInt(colors.length);
    return colors[rand];
  }

  _buildContent(Color textColor) {
    if (photoUrl.isEmpty) {
      final initials = name
          .trim()
          .split(' ')
          .map((word) => word.substring(0, 1))
          .take(letterCount)
          .join()
          .toUpperCase();
      // TODO: fit text in box
      return FittedBox(
        fit: BoxFit.contain,
        child: Text(
          initials,
          style: TextStyle(color: textColor, fontSize: 14),
        ),
      );
    } else {
      return Image.network(
        photoUrl,
      );
    }
  }
}
