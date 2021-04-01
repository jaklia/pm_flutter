import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/bloc/timeentries/timeentries_bloc.dart';
import 'package:pm_flutter/models/message.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:pm_flutter/models/timeentry.dart';
import 'package:pm_flutter/screens/projects/log_worktime.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  final User _user;

  UserDetailsScreen(this._user);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  UsersBloc _usersBloc;
  TimeEntriesBloc _worktimesBloc;
  ProfileBloc _profileBloc;

  TextEditingController msgController = TextEditingController(text: "");
  List<Message> messages = [
    Message(text: "1 Lorem ipsum dolor sit amet", senderId: "10"),
    Message(text: "2 Sed ut perspiciatis unde omnis iste natus error sit", senderId: "10"),
    Message(text: "3 At vero eos et accusamus et iusto odio dignissimos", senderId: "10"),
    Message(text: "4 Temporibus autem quibusdam et aut officiis", senderId: "10"),
    Message(text: "5 Lorem ipsum dolor sit amet", senderId: "10"),
    Message(text: "6 Sed ut perspiciatis unde omnis iste natus error sit", senderId: "10"),
    Message(text: "7 At vero eos et accusamus et iusto odio dignissimos", senderId: "10"),
    Message(text: "8 Temporibus autem quibusdam et aut officiis", senderId: "10"),
    Message(text: "9 Lorem ipsum dolor sit amet", senderId: "10"),
    Message(text: "10 Sed ut perspiciatis unde omnis iste natus error sit", senderId: "10"),
    Message(text: "11 At vero eos et accusamus et iusto odio dignissimos", senderId: "10"),
    Message(text: "12 Temporibus autem quibusdam et aut officiis", senderId: "10"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_usersBloc == null) {
      _usersBloc = Provider.of<UsersBloc>(context);
    } else {
      print("usersBloc not null");
    }
    _usersBloc.getUserWorktimes(widget._user);
    if (_worktimesBloc == null) {
      _worktimesBloc = Provider.of<TimeEntriesBloc>(context);
    } else {
      print("worktimesBloc not null");
    }
    if (_profileBloc == null) {
      _profileBloc = Provider.of<ProfileBloc>(context);
      print("profileBloc null");
    } else {
      print("profileBloc not null");
    }
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, i) => Row(
                mainAxisAlignment: messages[i].senderId == _profileBloc.userId
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 4,
                    color: messages[i].senderId != _profileBloc.userId
                        ? Theme.of(context).cardColor.withOpacity(0.6)
                        : Theme.of(context).primaryColorLight.withOpacity(0.6),
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 250,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(10),
                      child: Text(messages[i].text),
                    ),
                  ),
                ],
              ),
              reverse: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: msgController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => this.onSend(msgController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSend(String text) {
    Message message = Message(text: text, senderId: _profileBloc.userId);
    print(messages.length);
    print("send: ${msgController.text}");
    messages.insert(0, message);
    print(messages.length);
  }
}
