// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String fromUserId;
  Timestamp timestamp;
  bool follow;
  Activity({
    required this.id,
    required this.fromUserId,
    required this.timestamp,
    required this.follow,
  });

  // Activity({this.id, this.fromUserId, this.timestamp, this.follow});

  factory Activity.fromDoc(DocumentSnapshot doc) {
    return Activity(
      id: doc.id,
      fromUserId: doc['fromUserId'],
      timestamp: doc['timestamp'],
      follow: doc['follow'],
    );
  }

  Activity copyWith({
    String? id,
    String? fromUserId,
    Timestamp? timestamp,
    bool? follow,
  }) {
    return Activity(
      id: id ?? this.id,
      fromUserId: fromUserId ?? this.fromUserId,
      timestamp: timestamp ?? this.timestamp,
      follow: follow ?? this.follow,
    );
  }

  @override
  String toString() {
    return 'Activity(id: $id, fromUserId: $fromUserId, timestamp: $timestamp, follow: $follow)';
  }

  @override
  bool operator ==(covariant Activity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fromUserId == fromUserId &&
        other.timestamp == timestamp &&
        other.follow == follow;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fromUserId.hashCode ^
        timestamp.hashCode ^
        follow.hashCode;
  }
}
