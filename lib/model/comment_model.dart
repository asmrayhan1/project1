// Model for Comment
import 'package:project1/model/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentModel {
  int? id;
  int? schoolId;
  int? feedId;
  int? userId;
  int? replyCount;
  int? likeCount;
  String? commentTxt;
  int? parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? file;
  int? isAuthorAndAnonymous;
  List<dynamic>? replies;
  User? user;
  List<dynamic>? reactionTypes;
  List<dynamic>? totalLikes;
  dynamic commentLike;

  CommentModel({
    this.id,
    this.schoolId,
    this.feedId,
    this.userId,
    this.replyCount,
    this.likeCount,
    this.commentTxt,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.isAuthorAndAnonymous,
    this.replies,
    this.user,
    this.reactionTypes,
    this.totalLikes,
    this.commentLike,
  });

  // Factory constructor to create a CommentModel from JSON
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      schoolId: json['school_id'],
      feedId: json['feed_id'],
      userId: json['user_id'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      commentTxt: json['comment_txt'],
      parentId: json['parrent_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      file: json['file'],
      isAuthorAndAnonymous: json['is_author_and_anonymous'],
      replies: List<dynamic>.from(json['replies'] ?? []),
      user: User.fromJson(json['user']),
      reactionTypes: List<dynamic>.from(json['reaction_types'] ?? []),
      totalLikes: List<dynamic>.from(json['totalLikes'] ?? []),
      commentLike: json['commentlike'],
    );
  }

  // Convert CommentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'feed_id': feedId,
      'user_id': userId,
      'reply_count': replyCount,
      'like_count': likeCount,
      'comment_txt': commentTxt,
      'parrent_id': parentId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'file': file,
      'is_author_and_anonymous': isAuthorAndAnonymous,
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