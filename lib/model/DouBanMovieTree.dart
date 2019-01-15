import 'dart:convert' show json;

class DouBanMovieTree {

  int count;
  int start;
  int total;
  String title;
  List<MovieItem> subjects;

  DouBanMovieTree.fromParams({this.count, this.start, this.total, this.title, this.subjects});

  factory DouBanMovieTree(jsonStr) => jsonStr == null ? null : jsonStr is String ? new DouBanMovieTree.fromJson(json.decode(jsonStr)) : new DouBanMovieTree.fromJson(jsonStr);
  
  DouBanMovieTree.fromJson(jsonRes) {
    count = jsonRes['count'];
    start = jsonRes['start'];
    total = jsonRes['total'];
    title = jsonRes['title'];
    subjects = jsonRes['subjects'] == null ? null : [];

    for (var subjectsItem in subjects == null ? [] : jsonRes['subjects']){
            subjects.add(subjectsItem == null ? null : new MovieItem.fromJson(subjectsItem));
    }
  }

  @override
  String toString() {
    return '{"count": $count,"start": $start,"total": $total,"title": ${title != null?'${json.encode(title)}':'null'},"subjects": $subjects}';
  }
}

class MovieItem {

  int collect_count;
  String alt;
  String id;
  String original_title;
  String subtype;
  String title;
  String year;
  List<CastInfo> casts;
  List<DirectorInfo> directors;
  List<String> genres;
  Images images;
  Rating rating;

  MovieItem.fromParams({this.collect_count, this.alt, this.id, this.original_title, this.subtype, this.title, this.year, this.casts, this.directors, this.genres, this.images, this.rating});
  
  MovieItem.fromJson(jsonRes) {
    collect_count = jsonRes['collect_count'];
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    original_title = jsonRes['original_title'];
    subtype = jsonRes['subtype'];
    title = jsonRes['title'];
    year = jsonRes['year'];
    casts = jsonRes['casts'] == null ? null : [];

    for (var castsItem in casts == null ? [] : jsonRes['casts']){
            casts.add(castsItem == null ? null : new CastInfo.fromJson(castsItem));
    }

    directors = jsonRes['directors'] == null ? null : [];

    for (var directorsItem in directors == null ? [] : jsonRes['directors']){
            directors.add(directorsItem == null ? null : new DirectorInfo.fromJson(directorsItem));
    }

    genres = jsonRes['genres'] == null ? null : [];

    for (var genresItem in genres == null ? [] : jsonRes['genres']){
            genres.add(genresItem);
    }

    images = jsonRes['images'] == null ? null : new Images.fromJson(jsonRes['images']);
    rating = jsonRes['rating'] == null ? null : new Rating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"collect_count": $collect_count,"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"original_title": ${original_title != null?'${json.encode(original_title)}':'null'},"subtype": ${subtype != null?'${json.encode(subtype)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"year": ${year != null?'${json.encode(year)}':'null'},"casts": $casts,"directors": $directors,"genres": $genres,"images": $images,"rating": $rating}';
  }
}

class Rating {

  int max;
  int min;
  double average;
  String stars;

  Rating.fromParams({this.max, this.min, this.average, this.stars});
  
  Rating.fromJson(jsonRes) {
    max = jsonRes['max'];
    min = jsonRes['min'];
    average = jsonRes['average'];
    stars = jsonRes['stars'];
  }

  @override
  String toString() {
    return '{"max": $max,"min": $min,"average": $average,"stars": ${stars != null?'${json.encode(stars)}':'null'}}';
  }
}

class Images {

  String large;
  String medium;
  String small;

  Images.fromParams({this.large, this.medium, this.small});
  
  Images.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class DirectorInfo {

  String alt;
  String id;
  String name;
  Avatars avatars;

  DirectorInfo.fromParams({this.alt, this.id, this.name, this.avatars});
  
  DirectorInfo.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    avatars = jsonRes['avatars'] == null ? null : new Avatars.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"avatars": $avatars}';
  }
}

class Avatars {

  String large;
  String medium;
  String small;

  Avatars.fromParams({this.large, this.medium, this.small});
  
  Avatars.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

class CastInfo {

  String alt;
  String id;
  String name;
  DirectAvatar avatars;

  CastInfo.fromParams({this.alt, this.id, this.name, this.avatars});
  
  CastInfo.fromJson(jsonRes) {
    alt = jsonRes['alt'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    avatars = jsonRes['avatars'] == null ? null : new DirectAvatar.fromJson(jsonRes['avatars']);
  }

  @override
  String toString() {
    return '{"alt": ${alt != null?'${json.encode(alt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"avatars": $avatars}';
  }
}

class DirectAvatar {

  String large;
  String medium;
  String small;

  DirectAvatar.fromParams({this.large, this.medium, this.small});
  
  DirectAvatar.fromJson(jsonRes) {
    large = jsonRes['large'];
    medium = jsonRes['medium'];
    small = jsonRes['small'];
  }

  @override
  String toString() {
    return '{"large": ${large != null?'${json.encode(large)}':'null'},"medium": ${medium != null?'${json.encode(medium)}':'null'},"small": ${small != null?'${json.encode(small)}':'null'}}';
  }
}

