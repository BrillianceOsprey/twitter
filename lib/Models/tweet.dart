import 'package:cloud_firestore/cloud_firestore.dart';

class Tweet {
  String id;
  String authorId;
  String text;
  String image;
  Timestamp timestamp;
  int likes;
  int retweets;
  Tweet({
    required this.id,
    required this.authorId,
    required this.text,
    required this.image,
    required this.timestamp,
    required this.likes,
    required this.retweets,
  });

  // Tweet(
  //     {this.id,
  //     this.authorId,
  //     this.text,
  //     this.image,
  //     this.timestamp,
  //     this.likes,
  //     this.retweets});

  factory Tweet.fromDoc(DocumentSnapshot doc) {
    return Tweet(
      id: doc.id,
      authorId: doc['authorId'],
      text: doc['text'],
      image: doc['image'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
      retweets: doc['retweets'],
    );
  }

  Tweet copyWith({
    String? id,
    String? authorId,
    String? text,
    String? image,
    Timestamp? timestamp,
    int? likes,
    int? retweets,
  }) {
    return Tweet(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      text: text ?? this.text,
      image: image ?? this.image,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
    );
  }

  @override
  String toString() {
    return 'Tweet(id: $id, authorId: $authorId, text: $text, image: $image, timestamp: $timestamp, likes: $likes, retweets: $retweets)';
  }

  @override
  bool operator ==(covariant Tweet other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.authorId == authorId &&
        other.text == text &&
        other.image == image &&
        other.timestamp == timestamp &&
        other.likes == likes &&
        other.retweets == retweets;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        authorId.hashCode ^
        text.hashCode ^
        image.hashCode ^
        timestamp.hashCode ^
        likes.hashCode ^
        retweets.hashCode;
  }
}
