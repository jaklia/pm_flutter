import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pm_flutter/app_localizations.dart';
import 'package:pm_flutter/bloc/leaves/leaves_bloc.dart';
import 'package:pm_flutter/components/simple_info_row.dart';
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
        title: Text('Leaves'),
      ),
      body: StreamBuilder<List<Leave>>(
        stream: _leavesBloc.leaves,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text('Something went wrong\n${snapshot.error.toString()}'),
            );
          } else if (snapshot.hasData) {
            var leaves = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: leaves.length,
              itemBuilder: (context, i) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: leaves[i].approved ? Colors.green.shade300 : Colors.red.shade300,
                          width: 5,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SimpleInfoRow(
                          title: 'Status',
                          info: leaves[i].approved ? 'Approved' : 'Not approved',
                        ),
                        SizedBox(height: 10),
                        SimpleInfoRow(
                          title: 'From',
                          info: DateFormat.yMd(
                            AppLocalizations.of(context).locale.languageCode,
                          ).format(leaves[i].startDate),
                        ),
                        SizedBox(height: 10),
                        SimpleInfoRow(
                          title: 'To',
                          info: DateFormat.yMd(
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
    );
  }
}
