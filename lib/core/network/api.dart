class Api{

  static const String BASE_URL = "https://iap.ezycourse.com/api/app/";

  static const String LOGIN = "student/auth/login";

  static const String POST_FETCH_COMMUNITY = "teacher/community/getFeed?status=feed&";
  static const String POST_CREATE = "teacher/community/createFeedWithUpload?";
  static const String POST_CREATE_UPDATE_REACTION = "teacher/community/createLike?=&=&=&=";

  static const String GET_REACTION_LIST = "teacher/community/getAllReactionType?feed_id=180370";
  static const String GET_FETCH_COMMENT = "student/comment/getComment/:feedI_id?more=null";
  static const String GET_FETCH_REPLY = "student/comment/getReply/61231?more=null";

  static const String POST_CREATE_COMMENT = "student/comment/createComment";
  static const String POST_ADD_REPLY = "student/comment/createComment";

  static const String POST_LOGOUT = "student/auth/logout";
}