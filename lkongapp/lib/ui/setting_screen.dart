import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lkongapp/ui/home_list.dart';
import 'package:lkongapp/ui/modeled_app.dart';
import 'package:lkongapp/ui/screens.dart';
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

class SettingScreen extends StatelessWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget<SettingModel>(context, SettingModel.fromStore,
        (viewModel) {
      if (viewModel.user == null) {
        // viewModel.showLoginScreen(context);
      }
      return SettingView(model: viewModel);
    });
  }
}

class SettingModel {
  final AppConfig config;
  final User user;
  final Function(BuildContext, int) onSettingChanged;
  final Function(BuildContext, bool) dismissScreen;

  @override
  bool operator ==(other) {
    return other is SettingModel &&
        other.config == config &&
        other.user == user;
  }

  @override
  int get hashCode => hash2(config, user);

  SettingModel({
    @required this.config,
    @required this.user,
    @required this.onSettingChanged,
    @required this.dismissScreen,
  });

  static SettingModel fromStore(Store<AppState> store) {
    var _user = selectUser(store);

    return SettingModel(
      config: store.state.persistState.appConfig,
      user: _user,
      onSettingChanged: (BuildContext context, int value) {},
      dismissScreen: (BuildContext context, bool saveChanges) {
        Future(() {
          if (saveChanges) {
            store.dispatch(Dehydrate());
          }
          store.dispatch(UINavigationPop(context));
        });
      },
    );
  }

  SettingState createState() {
    return SettingState(config: config.toBuilder(), user: user);
  }
}

class SettingView extends StatefulWidget {
  final SettingModel model;

  const SettingView({Key key, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return model.createState();
  }
}

class SettingState extends State<SettingView> {
  final AppConfigBuilder config;
  final User user;

  AppConfig _originalCopy;

  TextEditingController _signatureTextController;

  Function(AppConfig) _showSaveDialog;

  @override
  void initState() {
    super.initState();

    _originalCopy = config.build();
    _signatureTextController = TextEditingController(
        text: config.accountSettings.currentSetting.signature);
  }

  void checkSaveConfig() {
    AppSetting newGlobalSetting = config.setting.build();
    AccountSetting newUserSetting =
        config.accountSettings.currentSetting.build();

    if (newGlobalSetting != _originalCopy.setting ||
        newUserSetting != _originalCopy.accountSettings.currentSetting) {
      config.accountSettings.accounts
          .updateValue(user.uid, (v) => newUserSetting);
      _showSaveDialog(config.build());
    }
  }

  SettingState({this.config, this.user});

  @override
  Widget build(BuildContext context) {
    final theme = LKModeledApp.modelOf(context).theme;

    _showSaveDialog = (AppConfig config) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text('保存设置'),
            content: Text('设置有改动，是否保存？'),
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
                  dispatchAction(context)(SaveConfig(config));
                  dispatchAction(context)(Dehydrate());
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    };

    CSWidgetStyle fontStyle =
        CSWidgetStyle(icon: Icon(Icons.font_download, color: theme.textColor));

    AppSettingBuilder setting = config.setting;
    AccountSettingBuilder account = config.accountSettings.currentSetting;

    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              checkSaveConfig();
            },
          ),
        ],
      ),
      body: CupertinoSettings(items: <Widget>[
        CSHeader('登录设置'),
        GestureDetector(
          child: CSControl(
            '保存用户名密码',
            CupertinoSwitch(
              value: setting.saveCredential,
              onChanged: (value) => setState(() {
                    setting.saveCredential = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.saveCredential = !setting.saveCredential;
              }),
        ),
        GestureDetector(
          child: CSControl(
            '自动登录',
            CupertinoSwitch(
              value: setting.autoLogin,
              onChanged: (value) => setState(() {
                    setting.autoLogin = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.autoLogin = !setting.autoLogin;
              }),
        ),
        GestureDetector(
          child: CSControl(
            '自动签到',
            CupertinoSwitch(
              value: setting.autoPunch,
              onChanged: (value) => setState(() {
                    setting.autoPunch = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.autoPunch = !setting.autoPunch;
              }),
        ),
        CSHeader('论坛设置'),
        GestureDetector(
          child: CSControl(
            '首页只显示主题',
            CupertinoSwitch(
              value: account.threadOnlyHome,
              onChanged: (value) => setState(() {
                    account.threadOnlyHome = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                account.threadOnlyHome = !account.threadOnlyHome;
              }),
        ),
        GestureDetector(
          child: CSControl(
            '显示版块信息',
            CupertinoSwitch(
              value: setting.showForumInfo,
              onChanged: (value) => setState(() {
                    setting.showForumInfo = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.showForumInfo = !setting.showForumInfo;
              }),
        ),
        CSHeader('签名'),
        CSWidget(
          TextField(
            style: TextStyle(fontSize: CS_ITEM_NAME_SIZE),
            controller: _signatureTextController,
            decoration: InputDecoration(
                hintText: "在此输入论坛发帖签名", border: InputBorder.none),
            onChanged: (text) {
              account.signature = text;
            },
            onSubmitted: (text) {
              setState(() {
                account.signature = text;
              });
            },
          ),
        ),
        CSHeader('阅读设置'),
        CSWidget(
            CupertinoSlider(
                min: 1,
                max: 11,
                value: setting.fontSize,
                onChanged: (double value) => setState(() {
                      setting.fontSize = value;
                    })),
            style: fontStyle),
        GestureDetector(
          child: CSControl(
            '屏蔽黑名单中人的帖子',
            CupertinoSwitch(
              value: setting.hideBlacklisterPost,
              onChanged: (value) => setState(() {
                    setting.hideBlacklisterPost = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.hideBlacklisterPost = !setting.hideBlacklisterPost;
              }),
        ),
        GestureDetector(
          child: CSControl(
            '显示详细发帖时间',
            CupertinoSwitch(
              value: setting.showDetailTime,
              onChanged: (value) => setState(() {
                    setting.showDetailTime = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.showDetailTime = !setting.showDetailTime;
              }),
        ),
        GestureDetector(
          child: CSControl(
            '检测帖子中的超链接',
            CupertinoSwitch(
              value: setting.detectLink == true,
              onChanged: (value) => setState(() {
                    setting.detectLink = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.detectLink = (setting.detectLink == false);
              }),
        ),
        CSHeader('图像设置'),
        GestureDetector(
          child: CSControl(
            '上传图片前进行裁剪',
            CupertinoSwitch(
              value: setting.noCropImage != true,
              onChanged: (value) => setState(() {
                    setting.noCropImage = !value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.noCropImage = (setting.noCropImage == false);
              }),
        ),
        GestureDetector(
          child: CSControl(
            '无图模式',
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                style: TextStyle(
                    fontSize: CS_HEADER_FONT_SIZE, color: theme.textColor),
                value: setting.noImageMode,
                items: ['关闭', '开启', '流量']
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
                    setting.noImageMode = _value;
                  });
                },
              ),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.noImageMode = (setting.noImageMode + 1) % 3;
              }),
        ),
        GestureDetector(
          child: CSControl(
            '无图模式下加载头像',
            CupertinoSwitch(
              value: setting.loadAvatar == true,
              onChanged: (value) => setState(() {
                    setting.loadAvatar = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.loadAvatar = (setting.loadAvatar == false);
              }),
        ),
        CSHeader('主题'),
        GestureDetector(
          child: CSControl(
            '夜间模式',
            CupertinoSwitch(
              value: setting.nightMode == true,
              onChanged: (value) => setState(() {
                    setting.nightMode = value;
                  }),
            ),
            fontSize: CS_ITEM_NAME_SIZE,
          ),
          onTap: () => setState(() {
                setting.nightMode = (setting.nightMode == false);
              }),
        ),
        CSControl(
          '日间主题',
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              style: TextStyle(
                  fontSize: CS_HEADER_FONT_SIZE, color: theme.textColor),
              value: setting.themeSetting.day,
              items: setting.themeSetting.theme
                  .build()
                  .asMap()
                  .map((int i, AppTheme theme) {
                    return MapEntry(
                        i,
                        DropdownMenuItem<int>(
                          value: i,
                          child: Text(theme.name),
                        ));
                  })
                  .values
                  .toList(),
              onChanged: (_value) {
                setState(() {
                  setting.themeSetting.day = _value;
                });
              },
            ),
          ),
          fontSize: CS_ITEM_NAME_SIZE,
        ),
        CSControl(
          '夜间主题',
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              style: TextStyle(
                  fontSize: CS_HEADER_FONT_SIZE, color: theme.textColor),
              value: setting.themeSetting.night,
              items: setting.themeSetting.theme
                  .build()
                  .asMap()
                  .map((int i, AppTheme theme) {
                    return MapEntry(
                        i,
                        DropdownMenuItem<int>(
                          value: i,
                          child: Text(theme.name),
                        ));
                  })
                  .values
                  .toList(),
              onChanged: (_value) {
                setState(() {
                  setting.themeSetting.night = _value;
                });
              },
            ),
          ),
          fontSize: CS_ITEM_NAME_SIZE,
        ),
        CSButton(
          CSButtonType.DEFAULT_CENTER,
          "修改主题设置",
          () {
            dispatchAction(context)(UINavigationPush(
                context, LKongAppRoutes.themeSetting, builder: (context) {
              return ThemeScreen(
                themeSetting: setting.themeSetting,
                onChange: (themes) {
                  setState(() {
                    setting.themeSetting.theme.replace(themes);
                  });
                },
              );
            }));
          },
          fontSize: CS_ITEM_NAME_SIZE,
        ),
        CSButton(
          CSButtonType.DESTRUCTIVE,
          "恢复默认主题",
          () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: Text('恢复默认主题'),
                  content: Text('这将会抹去你对所有自定义主题所做的修改，是否继续？'),
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
                        setState(() {
                          setting.themeSetting.replace(ThemeSetting());
                        });
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
        CSHeader("缓存管理"),
        CSButton(
          CSButtonType.DESTRUCTIVE,
          "删除所有缓存",
          () async {
            final cache = await CacheManager.getInstance();
            cache.dumpCache();
          },
          fontSize: CS_ITEM_NAME_SIZE,
        ),
        CSHeader(""),
        CSControl(
          '版权所有',
          Text(setting.copyright, style: TextStyle(color: Colors.grey)),
          fontSize: CS_ITEM_NAME_SIZE,
        ),
        CSHeader(""),
      ]),
    );
  }
}
