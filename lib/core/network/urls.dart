class Urls {
  static const String baseUrl = "http://10.40.11.99:8000/api";

  // Auth
  static const String register = "/register";
  static const String login = "/login";
  static const String emailVerify = "/email/verify";
  static const String authGoogleRedirect = "/auth/google/redirect";
  static const String authGoogleCallback = "/auth/google/callback";
  static const String logout = "/logout";
  static const String emailResend = "/email/resend";
  static const String user = "/user";

  // Product & Category
  static const String products = "/products";
  static const String categories = "/categories";
  static const String favoriteList = "/favorites";

  static String getProductUrl(int productId) => '$products/$productId';
  static String getProductFavoriteUrl(int productId) => '$products/$productId/favorite';
  static String getProductIdReviewUrl(int productId) => '$products/$productId/review';
  static String getCategoryUrl(int categoryId) => '$categories/$categoryId';


  // Cart
  static const String cart = "/cart";
  static const String cartItems = "/cart/items";

  // Payment
  static const String paymentMethods = "/payment-methods";

  // Order
  static const String checkoutPath = "/checkout";
  static const String ordersPath = "/orders";
  static String getOrderShippingMethodUrl(String orderId) => '$ordersPath/$orderId/shipping-method';
  static String getOrderShippingAddressUrl(String orderId) => '$ordersPath/$orderId/shipping-address';
  static String getOrderPaymentUrl(String orderId) => '$ordersPath/$orderId/payment';
  static String getOrderDetailsUrl(String orderId) => '$ordersPath/$orderId';
  static String getOrderTrackUrl(String orderNumber) => '$ordersPath/track/$orderNumber';


  // Shipping
  static const String shippingMethods = "/shipping-methods";
  static const String shippingAddresses = "/shipping-addresses";
}
