import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/themes/fonts.dart';
import 'package:flutter_testing/themes/themes_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailUser extends StatefulWidget {
  DetailUser({
    Key? key,
    required this.url,
    required this.firstname,
    required this.lastname,
    required this.tel,
    required this.email,
  }) : super(key: key);
  String url;
  String firstname;
  String lastname;
  String tel;
  String email;

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri makePhoneCall = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(makePhoneCall)) {
      throw 'Could not launch $makePhoneCall';
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri sendEmail = Uri.parse('mailto:$email');
    if (!await canLaunchUrlString(sendEmail.toString())) {
      throw 'Could not launch $sendEmail';
    } else {
      await launchUrlString(sendEmail.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        title: Text('ข้อมูลผู้ติดต่อ', style: sectionStyle),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.url,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.firstname,
                    style: titleStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.lastname,
                    style: titleStyle,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => _makePhoneCall(widget.tel),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "เบอร์โทรศัพท์  ${widget.tel}",
                  style: subtitleStyle,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _sendEmail(widget.email),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "อีเมล ${widget.email}",
                  style: subtitleStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
