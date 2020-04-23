class Destination {
  int id;
  String name;
  String slug;
  int hotelCount;
  String image;
  String thingsToDo;
  String lat;
  String lng;

  Destination(
      {this.id,
        this.name,
        this.slug,
        this.hotelCount,
        this.image,
        this.thingsToDo,
        this.lat,
        this.lng});

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    hotelCount = json['hotel_count'];
    image = json['image'];
    thingsToDo = json['things_to_do'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['hotel_count'] = this.hotelCount;
    data['image'] = this.image;
    data['things_to_do'] = this.thingsToDo;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
