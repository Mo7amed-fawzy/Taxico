abstract class AppStrings {
  // Table Names
  static const String tbZoneList = 'zone_list';
  static const String tbServiceDetail = 'service_detail';
  static const String tbPriceDetail = 'price_detail';
  static const String tbDocument = 'document';
  static const String tbZoneDocument = 'zone_detail';

  // Zone Table Columns
  static const String zoneId = "zone_id";
  static const String zoneName = "zone_name";
  static const String zoneJson = "zone_json";
  static const String city = "city";
  static const String tax = "tax";
  static const String status = "status";
  static const String createdDate = "created_date";
  static const String modifyDate = "modify_date";

  // Service Table Columns
  static const String serviceId = "service_id";
  static const String serviceName = "service_name";
  static const String seat = "seat";
  static const String color = "color";
  static const String icon = "icon";
  static const String topIcon = "top_icon";
  static const String gender = "gender";
  static const String description = "description";

  // Price Table Columns
  static const String priceId = "price_id";
  static const String baseCharge = "base_charge";
  static const String perKmCharge = "per_km_charge";
  static const String perMinCharge = "per_min_charge";
  static const String bookingCharge = "booking_charge";
  static const String miniFair = "mini_fair";
  static const String miniKm = "mini_km";
  static const String cancelCharge = "cancel_charge";

  // Document Table Columns
  static const String docId = "doc_id";
  static const String name = "name";
  static const String type = "type";

  // Zone Document Table Columns
  static const String zoneDocId = "zone_doc_id";
  static const String personalDoc = "personal_doc";
  static const String carDoc = "car_doc";
  static const String requiredPersonalDoc = "required_personal_doc";
  static const String requiredCarDoc = "required_car_doc";
}
