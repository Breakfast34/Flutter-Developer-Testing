import 'package:flutter/material.dart';
import 'package:flutter_testing/themes/fonts.dart';

class ListUsers extends StatelessWidget {
  ListUsers({
    Key? key,
    required this.url,
    required this.firstname,
    required this.lastname,
    required this.tel,
    required this.email,
    this.onTap,
  }) : super(key: key);
  String url;
  String firstname;
  String lastname;
  String tel;
  String email;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              url,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    firstname,
                    style: titleStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    lastname,
                    style: titleStyle,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, bottom: 5.0),
                child: Text(
                  tel,
                  style: subtitleStyle,
                ),
              ),
            ],
          ),
          subtitle: Text(
            email,
            style: subtitleStyle,
          ),
        ),
      ),
    );
  }
}
