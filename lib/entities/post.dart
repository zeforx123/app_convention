class Post {
  final String id;
  final String description;
  final String imageUrl;
  final String authorId;
  final String authorName;
  final String authorRole;
  final DateTime date;

  Post({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.authorId,
    required this.authorName,
    required this.authorRole,
    required this.date,
  });
}
