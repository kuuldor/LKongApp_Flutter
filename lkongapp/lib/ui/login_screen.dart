import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'package:lkongapp/utils/key.dart';
import 'package:lkongapp/ui/connected_widget.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';
import 'package:lkongapp/selectors/selectors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  static final GlobalKey<LoginState> scaffoldKey = GlobalKey<LoginState>();

  @override
  Widget build(BuildContext context) {
    return buildConnectedWidget(context, LoginViewModel.fromStore,
        (LoginViewModel viewModel) {
      var _formKey = LoginViewModel.formKey;

      final ValueKey _emailKey = LKongAppKeys.loginEmailKey;
      final ValueKey _passwordKey = LKongAppKeys.loginPasswordKey;
      final logo = CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset("assets/logo.png"),
      );

      if (!viewModel.loading &&
          viewModel.saveCredential &&
          !viewModel.authState.isAuthed) {
        if ((emailController.text == null || emailController.text == "") &&
            (passwordController.text == null ||
                passwordController.text == "")) {
          User user =
              viewModel.authState.userRepo[viewModel.authState.lastUser];
          emailController.text = user?.identity;

          passwordController.text = user?.password;
        }
      }

      final email = TextFormField(
        key: _emailKey,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (val) =>
            val.isEmpty || val.trim().length == 0 ? '请输入登录邮箱' : null,
        decoration: InputDecoration(
          hintText: '登录邮箱',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

      final password = TextFormField(
        controller: passwordController,
        key: _passwordKey,
        autocorrect: false,
        autofocus: false,
        obscureText: true,
        validator: (val) =>
            val.isEmpty || val.trim().length == 0 ? '请输入密码' : null,
        decoration: InputDecoration(
          hintText: '密码',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

      final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              return;
            }
            viewModel.onLoginPressed(
                context, emailController.text, passwordController.text);
          },
          color: Colors.lightBlueAccent,
          child: Text('登  录',
              style:
                  Theme.of(context).textTheme.title.apply(color: Colors.white)),
        ),
      );

      final saveCredential = CheckboxListTile(
        title: const Text('保存密码?'),
        value: viewModel.saveCredential,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool value) {
          viewModel.onSaveCredentialChanged(context, value);
        },
      );

      final form = Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 44.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            viewModel.authState.error == null
                ? Container()
                : Container(
                    padding: EdgeInsets.only(top: 26.0, bottom: 4.0),
                    child: Center(
                      child: Text(
                        viewModel.authState.error,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 24.0),
            loginButton,
            saveCredential
          ],
        ),
      );

      var stackChildren = <Widget>[];
      if (viewModel.loading) {
        stackChildren.add(Center(child: CircularProgressIndicator()));
      }
      stackChildren.add(form);

      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text("登录")),
        body: Stack(
          children: stackChildren,
        ),
      );
    });
  }
}

class LoginViewModel {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final bool loading;
  final bool saveCredential;
  final AuthState authState;

  final Function(BuildContext, String, String) onLoginPressed;
  final Function(BuildContext, bool) onSaveCredentialChanged;

  @override
  bool operator ==(other) {
    return other is LoginViewModel &&
        loading == other.loading &&
        saveCredential == other.saveCredential &&
        authState == other.authState;
  }

  @override
  int get hashCode => hash3(loading, saveCredential, authState);

  LoginViewModel({
    @required this.loading,
    @required this.authState,
    @required this.saveCredential,
    @required this.onLoginPressed,
    @required this.onSaveCredentialChanged,
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    AuthState authState = store.state.persistState.authState;

    var saveCredential = selectSetting(store).saveCredential;

    return LoginViewModel(
        loading: store.state.isLoading,
        authState: authState,
        saveCredential: saveCredential,
        onLoginPressed: (BuildContext context, String email, String password) {
          if (store.state.isLoading) {
            return;
          }

          final Completer<String> completer = new Completer<String>();
          store.dispatch(LoginRequest(
              completer,
              User().rebuild((b) => b
                ..identity = email.trim()
                ..password = password.trim())));
          completer.future.then((error) {
            if (error == null) {
              store.dispatch(UINavigationPop(context));
            }
          });
        },
        onSaveCredentialChanged: (BuildContext context, bool value) {
          store.dispatch(ChangeSetting((b) => b..saveCredential = value));
        });
  }
}
