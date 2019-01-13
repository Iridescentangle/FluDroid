
part of 'tec_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return new Data(
      apkLink: json['apkLink'] as String,
      author: json['author'] as String,
      chapterId: json['chapterId'] as int,
      chapterName: json['chapterName'] as String,
      collect: json['collect'] as bool,
      courseId: json['courseId'] as int,
      desc: json['desc'] as String,
      envelopePic: json['envelopePic'] as String,
      fresh: json['fresh'] as bool,
      id: json['id'] as int,
      link: json['link'] as String,
      niceDate: json['niceDate'] as String,
      origin: json['origin'] as String,
      projectLink: json['projectLink'] as String,
      publishTime: json['publishTime'] as int,
      superChapterId: json['superChapterId'] as int,
      superChapterName: json['superChapterName'] as String,
      tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
      title: json['title'] as String,
      type: json['type'] as int,
      userId: json['userId'] as int,
      visible: json['visible'] as int,
      zan: json['zan'] as int);
}

abstract class _$DataSerializerMixin {
  String get apkLink;
  String get author;
  int get chapterId;
  String get chapterName;
  bool get collect;
  int get courseId;
  String get desc;
  String get envelopePic;
  bool get fresh;
  int get id;
  String get link;
  String get niceDate;
  String get origin;
  String get projectLink;
  int get publishTime;
  int get superChapterId;
  String get superChapterName;
  List<String> get tags;
  String get title;
  int get type;
  int get userId;
  int get visible;
  int get zan;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'apkLink': apkLink,
        'author': author,
        'chapterId': chapterId,
        'chapterName': chapterName,
        'collect': collect,
        'courseId': courseId,
        'desc': desc,
        'envelopePic': envelopePic,
        'fresh': fresh,
        'id': id,
        'link': link,
        'niceDate': niceDate,
        'origin': origin,
        'projectLink': projectLink,
        'publishTime': publishTime,
        'superChapterId': superChapterId,
        'superChapterName': superChapterName,
        'tags': tags,
        'title': title,
        'type': type,
        'userId': userId,
        'visible': visible,
        'zan': zan
      };
}
