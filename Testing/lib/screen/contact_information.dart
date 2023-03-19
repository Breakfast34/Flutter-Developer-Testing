import 'package:flutter/material.dart';
import 'package:flutter_testing/Themes/themes_colors.dart';
import 'package:flutter_testing/components/list_user.dart';
import 'package:flutter_testing/models/user_model.dart';
import 'package:flutter_testing/screen/detail_user.dart';
import 'package:flutter_testing/services/user_apt.dart';
import 'package:flutter_testing/themes/fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UserData> userData = [];

  Future<void> fetchUserData() async {
    final response = await UserApi().fetchUserData();
    setState(() {
      userData = response;
    });
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('รายชื่อผู้ติดต่อ', style: sectionSytle)),
        backgroundColor: ThemeColor.appbar,
      ),
      body: ListView.builder(
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
            style: sectionSytle,
          ),
          content: Text(
            "Are you sure you wish to delete this item?",
            style: titleSytle,
            maxLines: 2,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("CANCEL", style: subtitleSytle),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("DELETE", style: subtitleSytle),
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
