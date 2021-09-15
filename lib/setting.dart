import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  final Color pannelColor;
  final String title;
  final bool _toggled = false;

  Setting({@required this.pannelColor, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SwitchListTile(
              title: Text('通知'),
              value: _toggled,
              secondary: Icon(Icons.airplanemode_active),
              onChanged: (bool value) {},
            ),
            Divider(
              thickness: 1.2,
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("予算入力"),
              onTap: () async {await Navigator.of(context).pushNamed('/budget');},
            ),
            Divider(
              thickness: 1.2,
            ),
            ListTile(
              leading: Icon(Icons.folder_open),
              title: Text("カテゴリ一覧"),
              onTap: () {},
            ),
            Divider(
              thickness: 1.2,
            ),
            SwitchListTile(
              title: Text("起動時に入力画面に推移"),
              value: _toggled,
              onChanged: (bool value) {},
              secondary: const Icon(Icons.fast_forward),
            ),
            Divider(
              thickness: 1.2,
            ),
            SwitchListTile(
              title: Text("ショートカット即時登録"),
              value: _toggled,
              onChanged: (bool value) {},
              secondary: const Icon(Icons.fast_forward),
            ),
            Divider(
              thickness: 1.2,
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("ショートカット編集"),
              onTap: () {
                Navigator.of(context).pushNamed('/shortcut');
              },
            ),
            Divider(
              thickness: 1.2,
            ),
          ],
        )
      )
    );
  }
}
