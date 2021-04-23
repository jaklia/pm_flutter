import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/leaves/leaves_bloc.dart';
import 'package:pm_flutter/components/form_dialog.dart';
import 'package:pm_flutter/components/simple_info_row.dart';
import 'package:pm_flutter/constants/localization.dart';
import 'package:pm_flutter/models/leave.dart';
import 'package:provider/provider.dart';

class LeavesScreen extends StatefulWidget {
  @override
  _LeavesScreenState createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  LeavesBloc _leavesBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _leavesBloc = Provider.of(context);
    _leavesBloc.getLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate(Strings.leaves)),
      ),
      body: RefreshIndicator(
        onRefresh: _leavesBloc.getLeaves,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  child: Text(
                    AppLocalizations.of(context).translate(Strings.leaveRequest),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => FormDialog(
                      title: 'Szabadság igénylése',
                      children: [
                        Text("data"),
                        Text("data"),
                      ],
                    ),
                    barrierDismissible: false,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Leave>>(
                  stream: _leavesBloc.leaves,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        child: Text('Something went wrong\n${snapshot.error.toString()}'),
                      );
                    } else if (snapshot.hasData) {
                      var leaves = snapshot.data;
                      return ListView.builder(
                        itemCount: leaves.length,
                        itemBuilder: (context, i) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: leaves[i].approved
                                        ? Colors.green.shade300
                                        : Colors.red.shade300,
                                    width: 5,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  SimpleInfoRow(
                                    title:
                                        AppLocalizations.of(context).translate(Strings.leaveStatus),
                                    info: leaves[i].approved
                                        ? AppLocalizations.of(context).translate(Strings.leaveAppr)
                                        : AppLocalizations.of(context)
                                            .translate(Strings.leaveNotAppr),
                                  ),
                                  SizedBox(height: 10),
                                  SimpleInfoRow(
                                    title: AppLocalizations.of(context)
                                        .translate(Strings.leaveStartDate),
                                    info: DateFormat.yMEd(
                                      AppLocalizations.of(context).locale.languageCode,
                                    ).format(leaves[i].startDate),
                                  ),
                                  SizedBox(height: 10),
                                  SimpleInfoRow(
                                    title: AppLocalizations.of(context)
                                        .translate(Strings.leaveEndDate),
                                    info: DateFormat.yMEd(
                                      AppLocalizations.of(context).locale.languageCode,
                                    ).format(leaves[i].endDate),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
