import 'package:flutter/material.dart';

import 'package:flutter_testing/components/list_user.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:flutter_testing/screen/detail_user.dart';
import 'package:flutter_testing/services/user_api.dart';
import 'package:flutter_testing/themes/fonts.dart';
import 'package:flutter_testing/themes/themes_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<UserData> userData = [];
  bool backToTop = false;
  bool isLastIndex = false;
  ScrollController scrollController = ScrollController();
  Future<void> fetchUserData() async {
    final response = await UserApi().fetchUserData();
    setState(() {
      userData = response;
    });
  }

  @override
  void initState() {
    fetchUserData();
    scrollUp();
    super.initState();
  }

  void scrollUp() {
    scrollController.addListener(() {
      setState(() {
        backToTop = scrollController.offset > 200 ? true : false;
        isLastIndex =
            scrollController.offset > scrollController.position.maxScrollExtent
                ? true
                : false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('รายชื่อผู้ติดต่อ', style: sectionStyle)),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return dismissbles(
            index,
            ListUsers(
              url: userData[index].image,
              firstname: userData[index].firstname,
              lastname: userData[index].lastname,
              tel: userData[index].tel,
              email: userData[index].email,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailUser(
                    url: userData[index].image,
                    firstname: userData[index].firstname,
                    lastname: userData[index].lastname,
                    tel: userData[index].tel,
                    email: userData[index].email,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: AnimatedContainer(
        duration: backToTop
            ? const Duration(milliseconds: 1000)
            : const Duration(milliseconds: 200),
        height: backToTop ? 100 : 0,
        child: Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: ThemeColors.camel,
            child: IconButton(
              onPressed: () {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              icon: Icon(
                Icons.arrow_upward,
                size: backToTop ? 20 : 0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Dismissible dismissbles(int index, Widget child) {
    return Dismissible(
      key: Key(userData[index].firstname),
      onDismissed: (direction) {
        setState(() {
          userData.removeAt(index);
        });
      },
      confirmDismiss: (direction) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Confirm",
            style: sectionStyle,
          ),
          content: Text(
            "Are you sure you wish to delete this item?",
            style: titleStyle,
            maxLines: 2,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("CANCEL", style: subtitleStyle),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("DELETE", style: subtitleStyle),
            ),
          ],
        ),
      ),
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: child,
    );
  }
}
