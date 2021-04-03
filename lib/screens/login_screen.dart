import 'package:flutter/material.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/screens/tabs.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController(text: "Teszt Elek");
  final _passwordController = TextEditingController(text: "Asdf123.");
  final _focusNode = FocusNode();
  ProfileBloc _profileBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context).translate(Strings.login)),
      // ),
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              //Colors.indigo.withOpacity(0.3),
              //Colors.green.withOpacity(0.3),
              // Colors.amber.withOpacity(0.2),
              Colors.grey.withOpacity(0.3),
              Colors.blue.withOpacity(0.2),
              Colors.blue.withOpacity(0.2),
              Colors.grey.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(0, 5),
                  blurRadius: 20,
                  spreadRadius: 0,
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate(Strings.username),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (text) {
                    FocusScope.of(context).requestFocus(_focusNode);
                  },
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate(Strings.password),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  focusNode: _focusNode,
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(AppLocalizations.of(context).translate(Strings.login)),
                    onPressed: onLogin,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLogin() async {
    // await Network.init();
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      //  TODO: alert
      print("name null");
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please enter your name and password to login"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      var res = await _profileBloc.login(_nameController.text, _passwordController.text);

      if (res) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TabScreen()));
      }
    }
  }
}
