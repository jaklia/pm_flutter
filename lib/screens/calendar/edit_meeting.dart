import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/room/room_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/components/add_users_dialog.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/room.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:provider/provider.dart';

class EditMeetingScreen extends StatefulWidget {
  @override
  _EditMeetingScreenState createState() => _EditMeetingScreenState();
}

class _EditMeetingScreenState extends State<EditMeetingScreen> {
  DateTime _from;
  DateTime _to;
  Room _room;
  List<User> _users;
  UsersBloc _usersBloc;
  RoomBloc _roomBloc;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    DateTime tmp = DateTime.now();
    _from = DateTime(tmp.year, tmp.month, tmp.day, tmp.hour + 1);
    _to = DateTime(tmp.year, tmp.month, tmp.day, tmp.hour + 2);
    _room = null;
    _users = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _usersBloc = Provider.of<UsersBloc>(context);
    _roomBloc = Provider.of<RoomBloc>(context);
    _profileBloc = Provider.of<ProfileBloc>(context);
    _roomBloc.getRooms();
    if (_users.length == 0) {
      _users.add(_profileBloc.profile.value);
      _usersBloc.setFilter([_profileBloc.profile.value]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate(Strings.newMeeting),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Időpont'),
            Divider(),
            InkWell(
              onTap: selectDate,
              child: Text(
                DateFormat.yMEd(
                  AppLocalizations.of(context).locale.languageCode,
                ).format(_from),
              ),
            ),
            renderTimes(context),
            SizedBox(height: 16),
            Text('Terem'),
            Divider(),
            renderRoom(context),
            SizedBox(height: 16),
            Text('Résztvevők'),
            Divider(),
            ElevatedButton(
              child: Text('Hozzáadás'),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AddUsersDialog(
                  users: _usersBloc.filteredUsers,
                  onSubmit: addUsers,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              itemBuilder: (context, i) {
                return Text(_users[i].name);
              },
            ),
          ],
        ));
  }

  Row renderTimes(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: Theme.of(context).accentColor,
        ),
        Expanded(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                DateFormat.Hm(
                  AppLocalizations.of(context).locale.languageCode,
                ).format(_from),
              ),
            ),
            onTap: () {},
          ),
        ),
        Text(' - '),
        Expanded(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                DateFormat.Hm(
                  AppLocalizations.of(context).locale.languageCode,
                ).format(_to),
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Row renderRoom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.meeting_room, color: Theme.of(context).accentColor),
        SizedBox(width: 10),
        Expanded(
          child: StreamBuilder<List<Room>>(
              stream: _roomBloc.rooms,
              builder: (context, snapshot) {
                return DropdownButton<Room>(
                  isExpanded: true,
                  hint: Text('Terem kiválasztása...'),
                  value: _room,
                  onChanged: selectRoom,
                  items: snapshot.hasData
                      ? snapshot.data
                          .map(
                            (room) => DropdownMenuItem<Room>(
                              value: room,
                              child: Text(room.name),
                            ),
                          )
                          .toList()
                      : [
                          DropdownMenuItem<Room>(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                );
              }),
        ),
      ],
    );
  }

  void selectDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: _from,
      firstDate: _from,
      lastDate: _from.add(
        Duration(days: 365),
      ),
    );
    if (date != null) {
      setState(() {
        _from = DateTime(
          date.year,
          date.month,
          date.day,
          _from.hour,
          _from.minute,
        );
        _to = DateTime(
          date.year,
          date.month,
          date.day,
          _to.hour,
          _to.minute,
        );
      });
    }
  }

  void selectRoom(Room room) {
    print('${room.id} - ${room.name}');
    setState(() {
      _room = room;
    });
  }

  void addUsers(List<User> users) {
    _usersBloc.setFilter(_users);
    setState(() {
      _users.addAll(users);
    });
  }

  void onSubmit() {
    // widget.onSubmit();
    closeDialog();
  }

  void onCancel() {
    closeDialog();
  }

  void onClose() {
    closeDialog();
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }
}
