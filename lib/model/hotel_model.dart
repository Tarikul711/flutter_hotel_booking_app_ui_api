import 'dart:convert';

//     final hotelModel = hotelModelFromJson(jsonString);
HotelModel hotelModelFromJson(String str) =>
    HotelModel.fromJson(json.decode(str));

String hotelModelToJson(HotelModel data) => json.encode(data.toJson());

class HotelModel {
  List<int> specialAmenities;
  Facets facets;
  int total;
  int page;
  List<Hotel> hotels;

  HotelModel({
    this.specialAmenities,
    this.facets,
    this.total,
    this.page,
    this.hotels,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        specialAmenities:
            List<int>.from(json["special_amenities"].map((x) => x)),
        facets: Facets.fromJson(json["facets"]),
        total: json["total"],
        page: json["page"],
        hotels: List<Hotel>.from(json["hotels"].map((x) => Hotel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "special_amenities": List<dynamic>.from(specialAmenities.map((x) => x)),
        "facets": facets.toJson(),
        "total": total,
        "page": page,
        "hotels": List<dynamic>.from(hotels.map((x) => x.toJson())),
      };
}

class Facets {
  List<List<int>> neighborhood;
  List<List<dynamic>> features;
  List<Model> neighborhoodModels;
  List<Model> propertyTypeModels;
  List<FeaturesModel> featuresModels;
  List<List<int>> propertyType;

  Facets({
    this.neighborhood,
    this.features,
    this.neighborhoodModels,
    this.propertyTypeModels,
    this.featuresModels,
    this.propertyType,
  });

  factory Facets.fromJson(Map<String, dynamic> json) => Facets(
        neighborhood: List<List<int>>.from(
            json["neighborhood"].map((x) => List<int>.from(x.map((x) => x)))),
        features: List<List<dynamic>>.from(
            json["features"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        neighborhoodModels: List<Model>.from(
            json["neighborhood_models"].map((x) => Model.fromJson(x))),
        propertyTypeModels: List<Model>.from(
            json["property_type_models"].map((x) => Model.fromJson(x))),
        featuresModels: List<FeaturesModel>.from(
            json["features_models"].map((x) => FeaturesModel.fromJson(x))),
        propertyType: List<List<int>>.from(
            json["property_type"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "neighborhood": List<dynamic>.from(
            neighborhood.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "features": List<dynamic>.from(
            features.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "neighborhood_models":
            List<dynamic>.from(neighborhoodModels.map((x) => x.toJson())),
        "property_type_models":
            List<dynamic>.from(propertyTypeModels.map((x) => x.toJson())),
        "features_models":
            List<dynamic>.from(featuresModels.map((x) => x.toJson())),
        "property_type": List<dynamic>.from(
            propertyType.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class FeaturesModel {
  String icon;
  int id;
  String name;

  FeaturesModel({
    this.icon,
    this.id,
    this.name,
  });

  factory FeaturesModel.fromJson(Map<String, dynamic> json) => FeaturesModel(
        icon: json["icon"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "id": id,
        "name": name,
      };
}

class Model {
  int id;
  String name;

  Model({
    this.id,
    this.name,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Hotel {
  int rating;
  List<int> payInfo;
  String pin;
  String cancellationPolicy;
  double rate;
  CheckTime checkInTime;
  bool image360Enabled;
  String id;
  int hasPanoramaImages;
  int reviewCount;
  dynamic review;
  CheckTime checkOutTime;
  List<int> amenities;
  String location;
  Offline offline;
  Type type;
  String thumbnail;
  double locationRating;
  String tags;
  bool crsSpecial;
  double minRate;
  String slug;
  String name;
  double discount;
  List<int> vatTax;

  Hotel({
    this.rating,
    this.payInfo,
    this.pin,
    this.cancellationPolicy,
    this.rate,
    this.checkInTime,
    this.image360Enabled,
    this.id,
    this.hasPanoramaImages,
    this.reviewCount,
    this.review,
    this.checkOutTime,
    this.amenities,
    this.location,
    this.offline,
    this.type,
    this.thumbnail,
    this.locationRating,
    this.tags,
    this.crsSpecial,
    this.minRate,
    this.slug,
    this.name,
    this.discount,
    this.vatTax,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        rating: json["rating"],
        payInfo: List<int>.from(json["pay_info"].map((x) => x)),
        pin: json["pin"],
        cancellationPolicy: json["cancellation_policy"] == null
            ? null
            : json["cancellation_policy"],
        rate: json["rate"].toDouble(),
        checkInTime: checkTimeValues.map[json["check_in_time"]],
        image360Enabled: json["image_360_enabled"],
        id: json["id"],
        hasPanoramaImages: json["hasPanoramaImages"],
        reviewCount: json["review_count"],
        review: json["review"],
        checkOutTime: checkTimeValues.map[json["check_out_time"]],
        amenities: List<int>.from(json["amenities"].map((x) => x)),
        location: json["location"],
        offline: Offline.fromJson(json["offline"]),
        type: typeValues.map[json["type"]],
        thumbnail: json["thumbnail"],
        locationRating: json["location_rating"].toDouble(),
        tags: json["tags"],
        crsSpecial: json["crs_special"],
        minRate: json["min_rate"].toDouble(),
        slug: json["slug"],
        name: json["name"],
        discount: json["discount"].toDouble(),
        vatTax: List<int>.from(json["vat_tax"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "pay_info": List<dynamic>.from(payInfo.map((x) => x)),
        "pin": pin,
        "cancellation_policy":
            cancellationPolicy == null ? null : cancellationPolicy,
        "rate": rate,
        "check_in_time": checkTimeValues.reverse[checkInTime],
        "image_360_enabled": image360Enabled,
        "id": id,
        "hasPanoramaImages": hasPanoramaImages,
        "review_count": reviewCount,
        "review": review,
        "check_out_time": checkTimeValues.reverse[checkOutTime],
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
        "location": location,
        "offline": offline.toJson(),
        "type": typeValues.reverse[type],
        "thumbnail": thumbnail,
        "location_rating": locationRating,
        "tags": tags,
        "crs_special": crsSpecial,
        "min_rate": minRate,
        "slug": slug,
        "name": name,
        "discount": discount,
        "vat_tax": List<dynamic>.from(vatTax.map((x) => x)),
      };
}

enum CheckTime { THE_1200_PM, THE_1130_AM, THE_1100_AM }

final checkTimeValues = EnumValues({
  "11:00 AM": CheckTime.THE_1100_AM,
  "11:30 AM": CheckTime.THE_1130_AM,
  "12:00 PM": CheckTime.THE_1200_PM
});

class Offline {
  bool status;
  DisplayText displayText;

  Offline({
    this.status,
    this.displayText,
  });

  factory Offline.fromJson(Map<String, dynamic> json) => Offline(
        status: json["status"],
        displayText: displayTextValues.map[json["display_text"]],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "display_text": displayTextValues.reverse[displayText],
      };
}

enum DisplayText { CONTACT_US, EMPTY }

final displayTextValues =
    EnumValues({"Contact Us": DisplayText.CONTACT_US, "": DisplayText.EMPTY});

enum Type { HOTEL, GUEST_HOUSE, MOTEL }

final typeValues = EnumValues({
  "Guest House": Type.GUEST_HOUSE,
  "Hotel": Type.HOTEL,
  "Motel": Type.MOTEL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
