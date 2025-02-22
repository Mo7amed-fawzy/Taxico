abstract class SVKey {
  static const mainUrl = "http://localhost:3001";
  static const baseUrl = '$mainUrl/api/';
  static const nodeUrl = mainUrl;

  static const svLogin = "${baseUrl}login";
  static const svProfileImageUpload = "${baseUrl}profile_image";
  static const svServiceAndZoneList = "${baseUrl}service_and_zone_list";
  static const svProfileUpdate = "${baseUrl}profile_update";

  static const svBankDetail = "${baseUrl}bank_detail";
  static const svDriverBankDetailUpdate = "${baseUrl}driver_bank_update";

  static const svBrandList = "${baseUrl}brand_list";
  static const svModelList = "${baseUrl}model_list";
  static const svSeriesList = "${baseUrl}series_list";
  static const svAddCar = "${baseUrl}add_car";
  static const svCarList = "${baseUrl}car_list";

  static const svDeleteCar = "${baseUrl}car_delete";
  static const svSetRunningCar = "${baseUrl}set_running_car";

  static const svSupportList = "${baseUrl}support_user_list";
  static const svSupportConnect = "${baseUrl}support_connect";
  static const svSupportSendMessage = "${baseUrl}support_message";
  static const svSupportClear = "${baseUrl}support_clear";

  static const svStaticData = "${baseUrl}static_data";

  static const svBookingRequest = "${baseUrl}booking_request";
  static const svUpdateLocationDriver = "${baseUrl}update_location";
  static const svDriverGoOnline = "${baseUrl}driver_online";

  static const svDriverRideAccept = "${baseUrl}ride_request_accept";
  static const svDriverRideDecline = "${baseUrl}ride_request_decline";

  static const svHome = "${baseUrl}home";
  static const svDriverWaitUser = "${baseUrl}driver_wait_user";
  static const svRideStart = "${baseUrl}ride_start";
  static const svRideStop = "${baseUrl}ride_stop";
  static const svRideCancel = "${baseUrl}driver_cancel_ride";
  static const svUserRideCancel = "${baseUrl}user_cancel_ride";

  static const svUserAllRides = "${baseUrl}user_all_ride_list";
  static const svDriverAllRides = "${baseUrl}driver_all_ride_list";

  static const svRideRating = "${baseUrl}ride_rating";
  static const svBookingDetail = "${baseUrl}booking_detail";

  static const svDriverSummary = "${baseUrl}driver_summary";

  static const svPersonalDocumentList = "${baseUrl}personal_document_list";
  static const svDriverUploadDocument = "${baseUrl}driver_update_document";
  static const svCarDocumentList = "${baseUrl}car_document_list";

  static const svChangePassword = "${baseUrl}change_password";
  static const svContactUs = "${baseUrl}contact_us";
}
