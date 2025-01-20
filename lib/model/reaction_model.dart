import 'dart:convert';

class Reaction {
  String? feed_id;
  int? totalReactions;
  List<LikeType>? likeType;

  Reaction({
    this.feed_id,
    this.totalReactions,
    this.likeType,
  });

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      feed_id: json['feed_id'],
      totalReactions: json['total_reactions'],
      likeType: (json['likeType'] as List)
          .map((e) => LikeType.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'feed_id' : feed_id,
      'total_reactions': totalReactions,
      'likeType': likeType?.map((e) => e.toJson()).toList(),
    };
  }
}

class LikeType {
  String? reactionType;
  Map<String, dynamic>? meta;
  int? feed_id;

  LikeType({
    this.reactionType,
    this.meta,
    this.feed_id
  });

  factory LikeType.fromJson(Map<String, dynamic> json) {
    return LikeType(
      reactionType: json['reaction_type'],
      feed_id: json['feed_id'],
      meta: json['meta'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reaction_type': reactionType,
      'feed_id' : feed_id,
      'meta': meta,
    };
  }
}