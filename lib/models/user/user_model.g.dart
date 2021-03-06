// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    idStr: json['idStr'] as String,
    name: json['name'] as String,
    screenName: json['screen_name'] as String,
    location: json['location'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    entities: json['entities'] == null
        ? null
        : Entities.fromJson(json['entities'] as Map<String, dynamic>),
    protected: json['protected'] as bool,
    followersCount: json['followersCount'] as int,
    friendsCount: json['friendsCount'] as int,
    listedCount: json['listedCount'] as int,
    createdAt: json['createdAt'] as String,
    favouritesCount: json['favouritesCount'] as int,
    geoEnabled: json['geoEnabled'] as bool,
    verified: json['verified'] as bool,
    statusesCount: json['statusesCount'] as int,
    contributorsEnabled: json['contributorsEnabled'] as bool,
    isTranslator: json['isTranslator'] as bool,
    isTranslationEnabled: json['isTranslationEnabled'] as bool,
    profileBackgroundColor: json['profileBackgroundColor'] as String,
    profileBackgroundImageUrl: json['profileBackgroundImageUrl'] as String,
    profileBackgroundImageUrlHttps:
        json['profileBackgroundImageUrlHttps'] as String,
    profileBackgroundTile: json['profileBackgroundTile'] as bool,
    profileImageUrl: json['profile_image_url'] as String,
    profileImageUrlHttps: json['profileImageUrlHttps'] as String,
    profileBannerUrl: json['profileBannerUrl'] as String,
    profileLinkColor: json['profileLinkColor'] as String,
    profileSidebarBorderColor: json['profileSidebarBorderColor'] as String,
    profileSidebarFillColor: json['profileSidebarFillColor'] as String,
    profileTextColor: json['profileTextColor'] as String,
    profileUseBackgroundImage: json['profileUseBackgroundImage'] as bool,
    hasExtendedProfile: json['hasExtendedProfile'] as bool,
    defaultProfile: json['defaultProfile'] as bool,
    defaultProfileImage: json['defaultProfileImage'] as bool,
    following: json['following'] as bool,
    followRequestSent: json['followRequestSent'] as bool,
    notifications: json['notifications'] as bool,
    translatorType: json['translatorType'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'idStr': instance.idStr,
      'name': instance.name,
      'screenName': instance.screenName,
      'location': instance.location,
      'description': instance.description,
      'url': instance.url,
      'entities': instance.entities,
      'protected': instance.protected,
      'followersCount': instance.followersCount,
      'friendsCount': instance.friendsCount,
      'listedCount': instance.listedCount,
      'createdAt': instance.createdAt,
      'favouritesCount': instance.favouritesCount,
      'geoEnabled': instance.geoEnabled,
      'verified': instance.verified,
      'statusesCount': instance.statusesCount,
      'contributorsEnabled': instance.contributorsEnabled,
      'isTranslator': instance.isTranslator,
      'isTranslationEnabled': instance.isTranslationEnabled,
      'profileBackgroundColor': instance.profileBackgroundColor,
      'profileBackgroundImageUrl': instance.profileBackgroundImageUrl,
      'profileBackgroundImageUrlHttps': instance.profileBackgroundImageUrlHttps,
      'profileBackgroundTile': instance.profileBackgroundTile,
      'profileImageUrl': instance.profileImageUrl,
      'profileImageUrlHttps': instance.profileImageUrlHttps,
      'profileBannerUrl': instance.profileBannerUrl,
      'profileLinkColor': instance.profileLinkColor,
      'profileSidebarBorderColor': instance.profileSidebarBorderColor,
      'profileSidebarFillColor': instance.profileSidebarFillColor,
      'profileTextColor': instance.profileTextColor,
      'profileUseBackgroundImage': instance.profileUseBackgroundImage,
      'hasExtendedProfile': instance.hasExtendedProfile,
      'defaultProfile': instance.defaultProfile,
      'defaultProfileImage': instance.defaultProfileImage,
      'following': instance.following,
      'followRequestSent': instance.followRequestSent,
      'notifications': instance.notifications,
      'translatorType': instance.translatorType,
    };
