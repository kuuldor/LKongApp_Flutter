import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/data/theme.dart';
import 'package:lkongapp/ui/home_list.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/utils/cache_manager.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:flutter_colorpicker/block_picker.dart';
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

    items.addAll(defaultThemes
        .map((theme) => theme2Widget(context, theme, readOnly: true)));
    if (customThemes.length > 0) {
      items.add(CSHeader('自定义主题'));
      items.addAll(customThemes
          .map((theme) => theme2Widget(context, theme, readOnly: false)));
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

  Widget theme2Widget(BuildContext context, AppTheme theme,
      {bool readOnly: false}) {
    final appTheme = LKModeledApp.modelOf(context).theme;
    return GestureDetector(
      child: CSControl(
        '${theme.name}',
        Row(
          children: <Widget>[
            Container(
              width: 24.0,
              height: 20.0,
              decoration: new BoxDecoration(
                color: htmlColor(theme.colors['main']),
                border: Border.all(color: appTheme.textColor),
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Container(
              width: 24.0,
              height: 20.0,
              decoration: new BoxDecoration(
                color: htmlColor(theme.colors['paper']),
                border: Border.all(color: appTheme.textColor),
              ),
            ),
          ],
        ),
        fontSize: CS_ITEM_NAME_SIZE,
      ),
      onTap: () {
        dispatchAction(context)(UINavigationPush(context, "/ThemeView",
            builder: (context) => ThemeView(
                theme: theme,
                readOnly: readOnly,
                onSave: (newTheme) {
                  setState(() {
                    int idx = customThemes.indexOf(theme);
                    if (idx != -1) {
                      customThemes.replaceRange(idx, idx + 1, [newTheme]);
                    }
                  });
                },
                onDelete: () {
                  setState(() {
                    customThemes.remove(theme);
                  });
                })));
      },
    );
  }
}

class ThemeView extends StatefulWidget {
  final AppTheme theme;
  final bool readOnly;
  final Function(AppTheme) onSave;
  final Function() onDelete;

  const ThemeView({
    Key key,
    @required this.theme,
    @required this.readOnly,
    @required this.onSave,
    this.onDelete,
  })  : assert(theme != null),
        assert(readOnly != null),
        assert(onSave != null),
        super(key: key);

  @override
  ThemeViewState createState() {
    return new ThemeViewState();
  }
}

class ThemeViewState extends State<ThemeView> {
  AppThemeBuilder theme;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    theme = AppThemeBuilder()..replace(widget.theme);
    _textController = TextEditingController(text: theme.name);
  }

  @override
  void dispose() {
    saveTheme();

    super.dispose();
  }

  void saveTheme() {
    if (!widget.readOnly) {
      AppTheme newTheme = theme.build();
      if (newTheme != widget.theme) {
        Future(() => widget.onSave(newTheme));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      CSHeader('主题名称'),
      widget.readOnly
          ? CSControl(
              theme.name,
              Container(),
              fontSize: CS_ITEM_NAME_SIZE,
            )
          : CSWidget(
              TextField(
                style: TextStyle(fontSize: CS_ITEM_NAME_SIZE),
                controller: _textController,
                decoration: InputDecoration(
                    hintText: "在此输入主题名称", border: InputBorder.none),
                onChanged: (text) {
                  print("OnChange");
                  theme.name = text;
                },
                onSubmitted: (text) {
                  setState(() {
                    theme.name = text;
                  });
                },
              ),
            ),
    ];

    if (theme.colors.length > 0) {
      final colors = theme.colors.build();

      items.add(CSHeader('色彩设置'));
      items.addAll(themeColorKeys.keys
          .map((name) => color2Widget(context, name, colors[name], (newColor) {
                setState(() {
                  theme.colors.updateValue(name, (v) => newColor,
                      ifAbsent: () => newColor);
                });
              }))
          .toList());
    }

    if (!widget.readOnly && widget.onDelete != null) {
      items.add(CSHeader(''));
      items.add(
        CSButton(
          CSButtonType.DESTRUCTIVE,
          "删除主题",
          () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: Text('删除 - ${widget.theme.name}'),
                  content: Text('被删除的自定义主题将无法恢复，是否继续？'),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    FlatButton(
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text("继续"),
                      onPressed: () {
                        widget.onDelete();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          fontSize: CS_ITEM_NAME_SIZE,
        ),
      );
    }

    items.add(CSHeader(''));

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.readOnly ? "" : "编辑 - "}${theme.name}'),
        actions: <Widget>[],
      ),
      body: CupertinoSettings(items: items),
    );
  }

  Widget color2Widget(BuildContext context, String name, String color,
      Function(String) onChange) {
    final appTheme = LKModeledApp.modelOf(context).theme;
    Color currentColor =
        color != null ? htmlColor(color) : appTheme.backgroundColor;

    return GestureDetector(
      child: CSControl(
        '${themeColorKeys[name]}',
        Container(
          width: 28.0,
          height: 20.0,
          decoration: new BoxDecoration(
            color: currentColor,
            border: Border.all(color: appTheme.textColor),
          ),
        ),
        fontSize: CS_ITEM_NAME_SIZE,
      ),
      onTap: () {
        if (!widget.readOnly) {
          showDialog(
            context: context,
            builder: (context) => ColorPickDialogContent(
                  currentColor: currentColor,
                  onChange: onChange,
                ),
          );
        }
      },
    );
  }
}

class ColorPickDialogContent extends StatefulWidget {
  final Color currentColor;
  final Function(String) onChange;

  const ColorPickDialogContent(
      {Key key, @required this.currentColor, this.onChange})
      : super(key: key);

  @override
  ColorPickDialogContentState createState() {
    return new ColorPickDialogContentState();
  }
}

final _htmlColors = htmlColorTable.values.map((hex) => htmlColor(hex)).toList();

class ColorPickDialogContentState extends State<ColorPickDialogContent> {
  Color pickedColor;

  int pickerMode;

  @override
  void initState() {
    super.initState();
    pickedColor = widget.currentColor;
    pickerMode = 0;
  }

  void changeColor(color) {
    setState(() {
      pickedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;

    Widget picker;
    switch (pickerMode) {
      case 0:
        picker = ColorPicker(
          pickerColor: pickedColor,
          onColorChanged: changeColor,
          enableAlpha: false,
          enableLabel: false,
          pickerAreaHeightPercent: 0.8,
        );
        break;
      case 1:
        picker = MaterialPicker(
          pickerColor: pickedColor,
          onColorChanged: changeColor,
          enableLabel: true, // only on portrait mode
        );
        break;
      case 2:
        picker = BlockPicker(
          pickerColor: pickedColor,
          availableColors: _htmlColors,
          onColorChanged: changeColor,
        );
        break;
      default:
        picker = Text(
          "色彩选择模式错误",
          style: TextStyle(color: Colors.red),
        );
        break;
    }
    return AlertDialog(
      title: const Text('选择颜色'),
      content: SingleChildScrollView(
        child: picker,
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Text('选择器模式：'),
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                style: TextStyle(
                  // fontSize: CS_HEADER_FONT_SIZE,
                  color: theme.textColor,
                ),
                value: pickerMode,
                items: ['全彩', '安卓', 'Web']
                    .asMap()
                    .map((int i, String title) {
                      return MapEntry(
                          i,
                          DropdownMenuItem<int>(
                            value: i,
                            child: Text(title),
                          ));
                    })
                    .values
                    .toList(),
                onChanged: (_value) {
                  setState(() {
                    pickerMode = _value;
                  });
                },
              ),
            ),
          ],
        ),
        FlatButton(
          child: Text('确定'),
          onPressed: () {
            if (widget.onChange != null) {
              widget.onChange(
                  "#" + pickedColor.value.toRadixString(16).padLeft(8, '0'));
            }
            Navigator.of(context).pop();
          },
        ),
      ],
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
