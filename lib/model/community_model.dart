import 'package:project1/model/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunityModel {
  int? id;
  int? schoolId;
  int? userId;
  String? feedTxt;
  String? status;
  String? slug;
  String? title;
  String? activityType;
  int? isPinned;
  String? fileType;
  List<dynamic>? files;
  int? likeCount;
  int? commentCount;
  int? shareCount;
  String? feedPrivacy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? publishDate;
  User? user;
  String? pic;

  CommunityModel({
    this.id,
    this.schoolId,
    this.userId,
    this.feedTxt,
    this.status,
    this.slug,
    this.title,
    this.activityType,
    this.isPinned,
    this.fileType,
    this.files,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.feedPrivacy,
    this.createdAt,
    this.updatedAt,
    this.publishDate,
    this.user,
    this.pic
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['id'],
      schoolId: json['school_id'],
      userId: json['user_id'],
      feedTxt: json['feed_txt'],
      status: json['status'],
      slug: json['slug'],
      title: json['title'],
      activityType: json['activity_type'],
      isPinned: json['is_pinned'],
      fileType: json['file_type'],
      files: json['files'] ?? [],
      likeCount: json['like_count'],
      commentCount: json['comment_count'],
      shareCount: json['share_count'],
      feedPrivacy: json['feed_privacy'],
      pic: json['pic'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      publishDate: json['publish_date'],
      user: User.fromJson(json['user']),
    );
  }

  String get createdAtAgo {
    return timeago.format(createdAt!);
  }

  String get updatedAtAgo {
    return timeago.format(updatedAt!);
  }
}
