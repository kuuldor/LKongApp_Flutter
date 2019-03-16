import 'package:flutter/material.dart';

class RadioDialog extends StatefulWidget {
  final List<String> selections;
  final String title;
  final Function(int) onSelected;

  const RadioDialog({
    Key key,
    @required this.selections,
    @required this.onSelected,
    this.title,
  })  : assert(selections != null),
        assert(onSelected != null),
        super(key: key);

  @override
  _RadioDialogState createState() => _RadioDialogState();
}

class _RadioDialogState extends State<RadioDialog> {
  int selected;
  @override
  void initState() {
    super.initState();

    selected = -1;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.title}'),
      content: SingleChildScrollView(
        child: Column(
          children: widget.selections
              .asMap()
              .map((int i, String title) {
                return MapEntry(
                  i,
                  FlatButton(
                      child: Row(
                        children: <Widget>[
                          Radio<int>(
                            value: i,
                            groupValue: selected,
                            onChanged: (int value) {
                              setState(() {
                                selected = value;
                              });
                            },
                          ),
                          Text('$title'),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          selected = i;
                        });
                      }),
                );
              })
              .values
              .toList(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            widget.onSelected(-1);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确定'),
          onPressed: () {
            widget.onSelected(selected);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
