import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  double _totalWidth = 350, _dashWidth = 10, _emptyWidth = 5, _dashHeight = 2;
  Color _dashColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _totalWidth ~/ (_dashWidth + _emptyWidth),
            (_) => Container(
          width: _dashWidth,
          height: _dashHeight,
          color: _dashColor,
          margin:
          EdgeInsets.only(left: _emptyWidth / 2, right: _emptyWidth / 2, top:20, bottom: 20),
        ),
      ),
    );
  }

  Widget _buildDashWidget() {

  }
}
