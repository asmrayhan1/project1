import 'package:project1/controller/comment/comment_generic.dart';

import '../../model/community_model.dart';

class CommunityGeneric {
  bool isLoading;
  List<CommunityModel> community;
  CommunityGeneric({this.isLoading = false, this.community = const []});

  CommunityGeneric update({bool? isLoading, List<CommunityModel>? newCommunity}){
    return CommunityGeneric(
      isLoading: isLoading?? this.isLoading,
      community: newCommunity?? this.community
    );
  }

  void delete(){
    this.community.removeRange(0, 1000);
  }
}