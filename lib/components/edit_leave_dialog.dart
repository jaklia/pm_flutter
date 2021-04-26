import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/components/form_dialog.dart';
import 'package:pm_flutter/components/simple_info_row.dart';
import 'package:pm_flutter/constants/localization.dart';

class EditLeaveDialog extends StatefulWidget {
  final Function onSubmit;

  EditLeaveDialog({this.onSubmit});

  @override
  _EditLeaveDialogState createState() => _EditLeaveDialogState();
}

class _EditLeaveDialogState extends State<EditLeaveDialog> {
  DateTime _from;
  DateTime _to;

  @override
  void initState() {
    super.initState();
    _from = DateTime.now();
    _to = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return FormDialog(
      title: 'Szabadság igénylése',
      cancelText: AppLocalizations.of(context).translate(Strings.cancel),
      submitText: AppLocalizations.of(context).translate(Strings.leaveRequest),
      onCancel: () => Navigator.of(context).pop(),
      onClose: () => Navigator.of(context).pop(),
      onSubmit: onSubmit,
      children: [
        SizedBox(height: 10),
        InkWell(
          onTap: selectFrom,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SimpleInfoRow(
              info: DateFormat.yMEd(
                AppLocalizations.of(context).locale.languageCode,
              ).format(_from),
              title: AppLocalizations.of(context).translate(Strings.leaveStartDate),
            ),
          ),
        ),
        InkWell(
          onTap: selectTo,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SimpleInfoRow(
              info: DateFormat.yMEd(
                AppLocalizations.of(context).locale.languageCode,
              ).format(_to),
              title: AppLocalizations.of(context).translate(Strings.leaveEndDate),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  void onSubmit() {
    widget.onSubmit(_from, _to);
    Navigator.of(context).pop();
  }

  Future<void> selectFrom() async {
    var from = await selectDate(_from);
    if (from != null) {
      setState(() {
        _from = from;
      });
    }
  }

  Future<void> selectTo() async {
    var to = await selectDate(_to);
    if (to != null) {
      setState(() {
        _to = to;
      });
    }
  }

  Future<DateTime> selectDate(DateTime date) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
  }
}
