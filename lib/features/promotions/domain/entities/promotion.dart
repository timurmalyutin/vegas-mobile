class Promotion {
  final String title;
  final String description;
  final Uri imageUrl;
  final Uri link;
  final Map<String, String> extraData;

  const Promotion({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.extraData,
  });
}
