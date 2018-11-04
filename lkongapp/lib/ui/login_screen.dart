import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lkongapp/utils/route.dart';
import 'package:lkongapp/utils/key.dart';
import 'package:lkongapp/models/models.dart';
import 'package:lkongapp/actions/actions.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
        converter: LoginViewModel.fromStore,
        builder: (context, vm) {
          return LoginView(
            viewModel: vm,
          );
        },
    );
  }
}

class LoginViewModel {
  bool isLoading;
  bool saveCredential;
  AuthState authState;
  final Function(BuildContext, String, String) onLoginPressed;
  final Function(BuildContext, bool) onSaveCredentialChanged;

  LoginViewModel({
    @required this.isLoading,
    @required this.authState,
    @required this.saveCredential,
    @required this.onLoginPressed,
    @required this.onSaveCredentialChanged,
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
        isLoading: store.state.isLoading,
        authState: store.state.authState,
        saveCredential: store.state.appConfig.setting.saveCredential,
        onLoginPressed: (BuildContext context, String email, String password) {
          if (store.state.isLoading) {
            return;
          }

          final Completer<bool> completer = new Completer<bool>();
          store.dispatch(LoginRequest(
              completer,
              User().rebuild((b) => b
                ..identity = email.trim()
                ..password = password.trim())));
          completer.future.then((succeed) {
            if (succeed) {
              Navigator.of(context).pop();
            }
          });
        },
        onSaveCredentialChanged: (BuildContext context, bool value) {
          store.dispatch(ChangeSetting((b) => b..saveCredential = value));
        });
  }
}

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  LoginView({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static final ValueKey _emailKey = LKongAppKeys.loginEmailKey;
  static final ValueKey _passwordKey = LKongAppKeys.loginPasswordKey;

  @override
  void didChangeDependencies() {
    var authState = widget.viewModel.authState;
    _emailController.text = authState.currentUser.identity;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = widget.viewModel;
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      key: _emailKey,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (val) => val.isEmpty || val.trim().length == 0
          ? 'Please enter your email'
          : null,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      key: _passwordKey,
      autocorrect: false,
      autofocus: false,
      obscureText: true,
      validator: (val) => val.isEmpty || val.trim().length == 0
          ? 'Please enter your password'
          : null,
      decoration: InputDecoration(
        hintText: 'Password',
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
              context, _emailController.text, _passwordController.text);
        },
        color: Colors.lightBlueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final saveCredential = CheckboxListTile(
      title: const Text('Save password?'),
      value: viewModel.saveCredential,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool value) {
        viewModel.onSaveCredentialChanged(context, value);
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
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
        ),
      ),
    );
  }
}
