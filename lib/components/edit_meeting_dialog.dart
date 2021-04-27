import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/profile/profile_bloc.dart';
import 'package:pm_flutter/bloc/room/room_bloc.dart';
import 'package:pm_flutter/bloc/users/users_bloc.dart';
import 'package:pm_flutter/components/form_dialog.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/room.dart';
import 'package:pm_flutter/models/user.dart';
import 'package:provider/provider.dart';

class EditMeetingDialog extends StatefulWidget {
  final Function onSubmit;

  EditMeetingDialog({@required this.onSubmit});

  @override
  _EditMeetingDialogState createState() => _EditMeetingDialogState();
}

class _EditMeetingDialogState extends State<EditMeetingDialog> {
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
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Új megbeszélés',
      children: [
        Text('Időpont'),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              DateFormat.yMEd(
                AppLocalizations.of(context).locale.languageCode,
              ).format(_from),
            ),
          ),
        ),
        renderTimes(context),
        renderRoom(context),
      ],
      cancelText: AppLocalizations.of(context).translate(Strings.cancel),
      submitText: 'Mentés',
      onSubmit: onSubmit,
      onCancel: onCancel,
      onClose: onClose,
    );
  }

  Row renderTimes(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: Theme.of(context).accentColor,
        ),
        Flexible(
          fit: FlexFit.tight,
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
        Flexible(
          fit: FlexFit.tight,
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

  void selectRoom(Room room) {
    print('${room.id} - ${room.name}');
    setState(() {
      _room = room;
    });
  }

  void onSubmit() {
    widget.onSubmit();
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
