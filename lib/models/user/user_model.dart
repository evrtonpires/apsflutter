import 'package:aps_5p/models/entities/entities_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  int id;
  String idStr;
  String name;
  String screenName;
  String location;
  String description;
  String url;
  Entities entities;
  bool protected;
  int followersCount;
  int friendsCount;
  int listedCount;
  String createdAt;
  int favouritesCount;
  bool geoEnabled;
  bool verified;
  int statusesCount;
  bool contributorsEnabled;
  bool isTranslator;
  bool isTranslationEnabled;
  String profileBackgroundColor;
  String profileBackgroundImageUrl;
  String profileBackgroundImageUrlHttps;
  bool profileBackgroundTile;
  String profileImageUrl;
  String profileImageUrlHttps;
  String profileBannerUrl;
  String profileLinkColor;
  String profileSidebarBorderColor;
  String profileSidebarFillColor;
  String profileTextColor;
  bool profileUseBackgroundImage;
  bool hasExtendedProfile;
  bool defaultProfile;
  bool defaultProfileImage;
  bool following;
  bool followRequestSent;
  bool notifications;
  String translatorType;

  User(
      {this.id,
      this.idStr,
      this.name,
      this.screenName,
      this.location,
      this.description,
      this.url,
      this.entities,
      this.protected,
      this.followersCount,
      this.friendsCount,
      this.listedCount,
      this.createdAt,
      this.favouritesCount,
      this.geoEnabled,
      this.verified,
      this.statusesCount,
      this.contributorsEnabled,
      this.isTranslator,
      this.isTranslationEnabled,
      this.profileBackgroundColor,
      this.profileBackgroundImageUrl,
      this.profileBackgroundImageUrlHttps,
      this.profileBackgroundTile,
      this.profileImageUrl,
      this.profileImageUrlHttps,
      this.profileBannerUrl,
      this.profileLinkColor,
      this.profileSidebarBorderColor,
      this.profileSidebarFillColor,
      this.profileTextColor,
      this.profileUseBackgroundImage,
      this.hasExtendedProfile,
      this.defaultProfile,
      this.defaultProfileImage,
      this.following,
      this.followRequestSent,
      this.notifications,
      this.translatorType});

  User.padrao();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
