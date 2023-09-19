import 'package:twilio_flutter/twilio_flutter.dart';

class MessagingService {
  void sendSMS(String phn, String mssg) {
    TwilioFlutter twilioFlutter = TwilioFlutter(
        accountSid: "ACf571d7de08d9e14c0441d57837f65329",
        authToken: "965b1cbc65d775ec3d98138735c412f6",
        twilioNumber: "+12569523630");

    twilioFlutter.sendSMS(toNumber: phn, messageBody: mssg);
  }
}
