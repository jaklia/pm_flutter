import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String cancelText;
  final Function onSubmit;
  final String submitText;
  final Function onCancel;
  final Function onClose;

  FormDialog({
    @required this.title,
    @required this.children,
    @required this.onSubmit,
    @required this.cancelText,
    @required this.submitText,
    @required this.onCancel,
    @required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            renderHeader(context),
            Divider(),
            renderBody(context),
            Divider(),
            renderFooter(context)
          ],
        ),
      ),
    );
  }

  Widget renderBody(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Row renderFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancel,
          child: Text(cancelText),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(submitText),
        ),
      ],
    );
  }

  Row renderHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: onClose,
        ),
      ],
    );
  }
}





/*

import 'package:flutter/material.dart';

class FormDialog extends StatelessWidget {
  final title;

  FormDialog({this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  Text('start date'),
                  Text('end date'),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Request'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

*/