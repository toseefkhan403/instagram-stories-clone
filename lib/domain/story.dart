import 'dart:convert';

class Story {
  final String imageUrl;
  final String title;

  Story({
    required this.imageUrl,
    required this.title,
  });

  Story copyWith({
    String? imageUrl,
    String? title,
  }) {
    return Story(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'title': title});
  
    return result;
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  @override
  String toString() => 'Story(imageUrl: $imageUrl, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Story &&
      other.imageUrl == imageUrl &&
      other.title == title;
  }

  @override
  int get hashCode => imageUrl.hashCode ^ title.hashCode;
}
