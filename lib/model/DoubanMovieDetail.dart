import 'dart:convert' show json;

class MovieTree {

  int status;
  MovieData data;

  MovieTree.fromParams({this.status, this.data});

  factory MovieTree(jsonStr) => jsonStr == null ? null : jsonStr is String ? new MovieTree.fromJson(json.decode(jsonStr)) : new MovieTree.fromJson(jsonStr);
  
  MovieTree.fromJson(jsonRes) {
    status = jsonRes['status'];
    data = jsonRes['data'] == null ? null : new MovieData.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"status": $status,"data": $data}';
  }
}

class MovieData {

  int db_num;
  int id;
  String casts;
  String db_link;
  String dbrating;
  String directors;
  String duration;
  String exhibit_pubdate;
  String genres;
  String img_url;
  String name;
  String pubdate;
  String summary;
  String trailer_urls;
  String writers;
  List<Link> links;
  List<String> photos;
  List<RelateSingle> relate_singles;

  MovieData.fromParams({this.db_num, this.id, this.casts, this.db_link, this.dbrating, this.directors, this.duration, this.exhibit_pubdate, this.genres, this.img_url, this.name, this.pubdate, this.summary, this.trailer_urls, this.writers, this.links, this.photos, this.relate_singles});
  
  MovieData.fromJson(jsonRes) {
    db_num = jsonRes['db_num'];
    id = jsonRes['id'];
    casts = jsonRes['casts'];
    db_link = jsonRes['db_link'];
    dbrating = jsonRes['dbrating'];
    directors = jsonRes['directors'];
    duration = jsonRes['duration'];
    exhibit_pubdate = jsonRes['exhibit_pubdate'];
    genres = jsonRes['genres'];
    img_url = jsonRes['img_url'];
    name = jsonRes['name'];
    pubdate = jsonRes['pubdate'];
    summary = jsonRes['summary'];
    trailer_urls = jsonRes['trailer_urls'];
    writers = jsonRes['writers'];
    links = jsonRes['links'] == null ? null : [];

    for (var linksItem in links == null ? [] : jsonRes['links']){
            links.add(linksItem == null ? null : new Link.fromJson(linksItem));
    }

    photos = jsonRes['photos'] == null ? null : [];

    for (var photosItem in photos == null ? [] : jsonRes['photos']){
            photos.add(photosItem);
    }

    relate_singles = jsonRes['relate_singles'] == null ? null : [];

    for (var relate_singlesItem in relate_singles == null ? [] : jsonRes['relate_singles']){
            relate_singles.add(relate_singlesItem == null ? null : new RelateSingle.fromJson(relate_singlesItem));
    }
  }

  @override
  String toString() {
    return '{"db_num": $db_num,"id": $id,"casts": ${casts != null?'${json.encode(casts)}':'null'},"db_link": ${db_link != null?'${json.encode(db_link)}':'null'},"dbrating": ${dbrating != null?'${json.encode(dbrating)}':'null'},"directors": ${directors != null?'${json.encode(directors)}':'null'},"duration": ${duration != null?'${json.encode(duration)}':'null'},"exhibit_pubdate": ${exhibit_pubdate != null?'${json.encode(exhibit_pubdate)}':'null'},"genres": ${genres != null?'${json.encode(genres)}':'null'},"img_url": ${img_url != null?'${json.encode(img_url)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"pubdate": ${pubdate != null?'${json.encode(pubdate)}':'null'},"summary": ${summary != null?'${json.encode(summary)}':'null'},"trailer_urls": ${trailer_urls != null?'${json.encode(trailer_urls)}':'null'},"writers": ${writers != null?'${json.encode(writers)}':'null'},"links": $links,"photos": $photos,"relate_singles": $relate_singles}';
  }
}

class RelateSingle {

  String id;
  String img_url;
  String name;

  RelateSingle.fromParams({this.id, this.img_url, this.name});
  
  RelateSingle.fromJson(jsonRes) {
    id = jsonRes['id'];
    img_url = jsonRes['img_url'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": ${id != null?'${json.encode(id)}':'null'},"img_url": ${img_url != null?'${json.encode(img_url)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

class Link {

  String link;
  String name;

  Link.fromParams({this.link, this.name});
  
  Link.fromJson(jsonRes) {
    link = jsonRes['link'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

