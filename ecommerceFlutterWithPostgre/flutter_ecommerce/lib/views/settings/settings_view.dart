import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants.dart';
import 'package:flutter_ecommerce/services/auth_service.dart';
import 'package:flutter_ecommerce/services/data_service.dart';
import 'package:flutter_ecommerce/views/base_view.dart';
import 'package:flutter_ecommerce/views/beginning.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text(
                'Hesap Ayarları',
                style: kSettingsTitleFont,
              ),
              tiles: [
                FirebaseAuth.instance.currentUser!.isAnonymous
                    ? SettingsTile(
                        title: Text(
                          'Şifremi Değiştir',
                          style: kSettingsLabelFont,
                        ),
                        leading: Icon(
                          Icons.lock,
                          color: kSettingsLeadingColor,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: kSettingsTrailingColor,
                        ),
                        onPressed: null,
                        enabled: false,
                        description:
                            Text('Anonim kullanıcılar bu işlemi yapamaz'),
                      )
                    : SettingsTile(
                        title: Text(
                          'Şifremi Değiştir',
                          style: kSettingsLabelFont,
                        ),
                        leading: Icon(
                          Icons.lock,
                          color: kSettingsLeadingColor,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: kSettingsTrailingColor,
                        ),
                        onPressed: (BuildContext context) {
                          Provider.of<AuthService>(context, listen: false)
                              .sendPasswordResetEmail(FirebaseAuth
                                  .instance.currentUser!.email
                                  .toString());
                          final snackBar = SnackBar(
                            content: Text('Mailinizi kontrol ediniz'),
                            backgroundColor: Colors.orange,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                FirebaseAuth.instance.currentUser!.isAnonymous
                    ? SettingsTile(
                        title: Text(
                          'Hesabımı Sil',
                          style: kSettingsLabelFont,
                        ),
                        leading: Icon(
                          Icons.person_remove,
                          color: kSettingsLeadingColor,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: kSettingsTrailingColor,
                        ),
                        onPressed: null,
                        enabled: false,
                        description:
                            Text('Anonim kullanıcılar bu işlemi yapamaz'),
                      )
                    : SettingsTile(
                        title: Text(
                          'Hesabımı Sil',
                          style: kSettingsLabelFont,
                        ),
                        leading: Icon(
                          Icons.person_remove,
                          color: kSettingsLeadingColor,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: kSettingsTrailingColor,
                        ),
                        onPressed: (BuildContext context) {
                          Provider.of<AuthService>(context, listen: false)
                              .deleteAccount();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Beginning()),
                            (Route<dynamic> route) => false,
                          );
                        },
                      ),
                FirebaseAuth.instance.currentUser!.isAnonymous
                    ? SettingsTile(
                        title: Text(
                          'Çıkış Yap',
                          style: kSettingsLabelFont,
                        ),
                        leading: Icon(
                          Icons.exit_to_app,
                          color: kSettingsLeadingColor,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: kSettingsTrailingColor,
                        ),
                        onPressed: null,
                        enabled: false,
                        description: Text(
                            'Anonim kullanıcılar bu işlemi yapamaz. Toolbardan çıkış yapınız.'),
                      )
                    : SettingsTile(
                        title: Text(
                          'Çıkış Yap',
                          style: kSettingsLabelFont,
                        ),
                        leading: Icon(
                          Icons.exit_to_app,
                          color: kSettingsLeadingColor,
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: kSettingsTrailingColor,
                        ),
                        onPressed: (BuildContext context) {
                          Provider.of<AuthService>(context, listen: false)
                              .SignOut();
                        },
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
