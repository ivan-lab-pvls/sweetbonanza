import 'dart:async';

import 'package:animated_flip_widget/animated_flip_widget/flip_controler.dart';
import 'package:animated_flip_widget/animated_flip_widget/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_bonanza_app/models/card_model.dart';
import 'package:sweet_bonanza_app/theme/colors.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    required this.card,
    required this.index,
    required this.onCardPressed,
    super.key,
  });

  final CardModel card;
  final int index;
  final ValueChanged<int> onCardPressed;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  void _handleCardTap() {
    if (widget.card.state == CardState.hidden) {
      Timer(const Duration(milliseconds: 100), () {
        widget.onCardPressed(widget.index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleCardTap,
      child: Center(
        child: AnimatedFlipWidget(
          clickable: false,
          flipDirection: FlipDirection.horizontal,
          controller: widget.card.flipController,
          front: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.pink, AppColors.purple],
              ),
            ),
            width: 80,
            height: 80,
          ),
          back: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                color: AppColors.purple,
              ),
              Image.asset(
                widget.card.image,
                width: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
