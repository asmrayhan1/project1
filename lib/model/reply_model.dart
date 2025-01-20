import 'package:project1/model/user_model.dart';

class ReplyModel {
  int? id;
  int? schoolId;
  int? feedId;
  int? userId;
  int? replyCount;
  int? likeCount;
  String? commentTxt;
  int? parrentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? file;
  int? isAuthorAndAnonymous;
  dynamic gift;
  dynamic sellerId;
  dynamic giftedCoins;
  List<dynamic>? replies;
  User? user;
  List<dynamic>? reactionTypes;
  List<dynamic>? totalLikes;
  dynamic commentLike;

  ReplyModel({
    this.id,
    this.schoolId,
    this.feedId,
    this.userId,
    this.replyCount,
    this.likeCount,
    this.commentTxt,
    this.parrentId,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.isAuthorAndAnonymous,
    this.gift,
    this.sellerId,
    this.giftedCoins,
    this.replies,
    this.user,
    this.reactionTypes,
    this.totalLikes,
    this.commentLike,
  });

  // Factory method to create a Reply object from JSON
  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      id: json['id'],
      schoolId: json['school_id'],
      feedId: json['feed_id'],
      userId: json['user_id'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      commentTxt: json['comment_txt'],
      parrentId: json['parrent_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      file: json['file'],
      isAuthorAndAnonymous: json['is_author_and_anonymous'],
      gift: json['gift'],
      sellerId: json['seller_id'],
      giftedCoins: json['gifted_coins'],
      replies: json['replies'] != null ? List<dynamic>.from(json['replies']) : [],
      user: User.fromJson(json['user']),
      reactionTypes: json['reaction_types'] != null ? List<dynamic>.from(json['reaction_types']) : [],
      totalLikes: json['totalLikes'] != null ? List<dynamic>.from(json['totalLikes']) : [],
      commentLike: json['commentlike'],
    );
  }

  // Method to convert a Reply object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'feed_id': feedId,
      'user_id': userId,
      'reply_count': replyCount,
      'like_count': likeCount,
      'comment_txt': commentTxt,
      'parrent_id': parrentId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'file': file,
      'is_author_and_anonymous': isAuthorAndAnonymous,
      'gift': gift,
      'seller_id': sellerId,
      'gifted_coins': giftedCoins,
      'replies': replies,
      'user': user?.toJson(),
      'reaction_types': reactionTypes,
      'totalLikes': totalLikes,
      'commentlike': commentLike,
    };
  }

  String get createdAtAgo {
    if (createdAt == null) return 'N/A';
    Duration difference = DateTime.now().difference(createdAt!);
    return _formatDuration(difference);
  }

  String get updatedAtAgo {
    if (updatedAt == null) return 'N/A';
    Duration difference = DateTime.now().difference(updatedAt!);
    return _formatDuration(difference);
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds < 60) {
      return '${duration.inSeconds}s'; // Seconds
    } else if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m'; // Minutes
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h'; // Hours
    } else {
      return '${duration.inDays}d'; // Days
    }
  }
}
