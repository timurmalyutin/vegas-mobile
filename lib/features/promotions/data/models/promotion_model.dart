import '../../domain/entities/promotion.dart';

class PromotionModel {
  final String title;
  final String description;
  final String imageUrl;
  final String link;
  final String? visibility;
  final String? group;

  const PromotionModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    this.visibility,
    this.group,
  });

  Promotion toEntity() {
    return Promotion(
      title: title,
      description: description,
      imageUrl: Uri.parse(imageUrl),
      link: Uri.parse(link),
      extraData: {
        'visibility': visibility ?? '',
        'group': group ?? '',
      },
    );
  }
}
