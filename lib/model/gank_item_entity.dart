class GankItemEntity {
  String createdAt;
  String publishedAt;
  String itemId;
  String source;
  List<String> images;
  bool used;
  String type;
  String url;
  String desc;
  String who;

  String category;
  bool isTitle = false;

  GankItemEntity.title(this.isTitle, this.category);

  GankItemEntity.fromJson(Map<String, dynamic> json, {String category}) {
    ///取id，其实对应的是gank mongo数据库中的id值，搜索获取的id名称为ganhuo_id，所以这里直接使用？？来取.
    ///为什么有一个itemId，这个是为了存本地objectDb中，避免与它自己的_id冲突.
    this.itemId = json['itemId'] ?? json['_id'] ?? json['ganhuo_id'];
    this.category = category;

    images =
    // as 类型转换
        json['images']?.map<String>((image) => image as String)?.toList() ?? [];
    createdAt = json['createdAt'];
    publishedAt = json['publishedAt'];
    source = json['source'];
    used = json['used'];
    type = json['type'];
    url = json['url'];
    desc = json['desc'];
    who = json['who'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (itemId != null) {
      data['createdAt'] = this.createdAt;
      data['publishedAt'] = this.publishedAt;
//		data['_id'] = this.itemId;
      data['source'] = this.source;
      data['used'] = this.used;
      data['images'] = this.images;
      data['type'] = this.type;
      data['url'] = this.url;
      data['desc'] = this.desc;
      data['who'] = this.who;
    }

    return data;
  }
}
