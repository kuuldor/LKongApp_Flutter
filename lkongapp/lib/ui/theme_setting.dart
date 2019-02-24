import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/ui/home_list.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/utils.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:flutter_cupertino_settings/flutter_cupertino_settings.dart';
import 'package:lkongapp/ui/forum_list.dart';
import 'package:lkongapp/selectors/selectors.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/ui/app_drawer.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class ThemeScreen extends StatefulWidget {
  final ThemeSettingBuilder themeSetting;
  final Function(List<AppTheme>) onChange;

  ThemeScreen({Key key, @required this.themeSetting, @required this.onChange})
      : assert(themeSetting != null),
        super(key: key);

  @override
  ThemeScreenState createState() {
    return new ThemeScreenState();
  }
}

class ThemeScreenState extends State<ThemeScreen> {
  List<AppTheme> allThemes;
  List<AppTheme> defaultThemes;
  List<AppTheme> customThemes;

  @override
  void initState() {
    super.initState();
    allThemes = widget.themeSetting.theme.build().toList();
    defaultThemes = allThemes.sublist(0, 2);
    customThemes = <AppTheme>[];
    if (allThemes.length > 2) {
      customThemes.addAll(allThemes.sublist(2));
    }
  }

  @override
  void dispose() {
    if (widget.onChange != null) {
      List<AppTheme> themes = <AppTheme>[]
        ..addAll(defaultThemes)
        ..addAll(customThemes);
      Future(() => widget.onChange(themes));
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      CSHeader('默认主题'),
    ];
    items.addAll(defaultThemes.map((theme) => GestureDetector(
          child: CSControl(
            '${theme.name}',
            Container(),
          ),
          onTap: () => setState(() {}),
        )));
    if (customThemes.length > 0) {
      items.add(CSHeader('自定义主题'));
      items.addAll(customThemes.map((theme) => GestureDetector(
            child: CSControl(
              '${theme.name}',
              Container(),
            ),
            onTap: () => setState(() {}),
          )));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('主题设置'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThemeDialogContent(
                    templates: defaultThemes,
                    customThemeCount: customThemes.length,
                    onSave: (newTheme) {
                      setState(() {
                        customThemes.add(newTheme);
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: CupertinoSettings(items: items),
    );
  }
}

class ThemeDialogContent extends StatefulWidget {
  final List<AppTheme> templates;
  final int customThemeCount;
  final Function(AppTheme) onSave;

  const ThemeDialogContent(
      {Key key,
      @required this.templates,
      @required this.onSave,
      @required this.customThemeCount})
      : super(key: key);

  @override
  ThemeDialogContentState createState() {
    return new ThemeDialogContentState();
  }
}

class ThemeDialogContentState extends State<ThemeDialogContent> {
  TextEditingController editCtrl;
  int selectedTemplate;

  @override
  void initState() {
    super.initState();

    editCtrl = TextEditingController();
    selectedTemplate = -1;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('新建主题'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
                controller: editCtrl,
                decoration: new InputDecoration(hintText: '在此输入主题名称')),
            SizedBox(
              height: 8.0,
            ),
            Text('选择模板'),
            Row(
              children: <Widget>[
                Checkbox(
                  value: 0 == selectedTemplate,
                  onChanged: (bool value) {
                    setState(() {
                      if (value) {
                        selectedTemplate = 0;
                      } else {
                        selectedTemplate = 1;
                      }
                    });
                  },
                ),
                Text("${widget.templates[0].name}"),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: 1 == selectedTemplate,
                  onChanged: (bool value) {
                    setState(() {
                      if (value) {
                        selectedTemplate = 1;
                      } else {
                        selectedTemplate = 0;
                      }
                    });
                  },
                ),
                Text("${widget.templates[1].name}"),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: Text("不保存"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("保存"),
          onPressed: () {
            if (selectedTemplate == 0 || selectedTemplate == 1) {
              String themeName = editCtrl.text;
              if (themeName == null || themeName.trim().length == 0) {
                themeName =
                    "${widget.templates[selectedTemplate].name}-复制${widget.customThemeCount + 1}";
              }
              final newTheme = widget.templates[selectedTemplate]
                  .rebuild((b) => b..name = themeName.trim());
              widget.onSave(newTheme);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
