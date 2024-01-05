import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartstock_pro/customerui/controller/product_controller.dart';


import 'env.dart';

late GlobalKey<FormState> paymentForm;
Map<String, dynamic>? paymentIntentData;
ProductController controller = Get.find<ProductController>();
Future<void> makePayment(
    {required String amount, required String currency}) async {
  try {
    paymentIntentData = await createPaymentIntent(amount, currency);

    const gpay = PaymentSheetGooglePay(
      merchantCountryCode: "IN",
      currencyCode: "INR",
      testEnv: true,
    );
    if (paymentIntentData != null) {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          googlePay: gpay,
          merchantDisplayName: 'Adiwele',
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ),
      );
      displayPaymentSheet();
    }
  } catch (e, s) {
    debugPrint('exception:$e$s');
  }
}

displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
    Get.snackbar('Payment Status', 'Payment received',
        backgroundColor: Colors.green);
    controller.storeOrderDetails();
  } on StripeException catch (e) {
    Get.snackbar('Payment Status', '${e.error.localizedMessage}',
        backgroundColor: Colors.red);
  } catch (e) {
    Get.snackbar('An unexpected error occurred:', '$e',
        backgroundColor: Colors.red);
  }
}

createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card'
    };
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      body: body,
      headers: {
        'Authorization': 'Bearer $stripeSecretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    return jsonDecode(response.body.toString());
  } catch (e) {
    Get.snackbar('An unexpected error occurred:', '$e',
        backgroundColor: Colors.red);
  }
}
