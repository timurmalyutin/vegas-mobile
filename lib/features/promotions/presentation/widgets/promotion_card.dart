import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../domain/entities/promotion.dart';
import '../../../../app/constants/app_colors.dart';

class PromotionCard extends StatelessWidget {
  final Promotion promotion;

  const PromotionCard({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 400)),
        SlideEffect(begin: Offset(0, 0.1), duration: Duration(milliseconds: 500)),
      ],
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        const SizedBox(height: 12),
        _buildTitle(context),
        const SizedBox(height: 4),
        _buildDescription(context),
      ],
    )
        .padding(all: 16)
        .decorated(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    )
        .padding(horizontal: 16, vertical: 8);
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        promotion.imageUrl.toString(),
        width: double.infinity,
        height: 180,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Container(
            width: double.infinity,
            height: 180,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        },
        errorBuilder: (_, __, ___) => Image.network(
          'https://placehold.in/300x200@2x.png',
          width: double.infinity,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _buildTitle(BuildContext context) {
    return Text(
      promotion.title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.main,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      promotion.description,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.white.withOpacity(0.7),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
