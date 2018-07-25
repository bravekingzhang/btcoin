import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NetWork.dart';
import 'widget/dioImage.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  static const String routeName = '/register';

  @override
  RegisterState createState() => new RegisterState();
}

class PersonData {
  String name = '';
  String email = '';
  String phoneNumber = '';
  String veryCode = '';
  String phoneCode = '';
  String password = '';
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 16,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child:
              new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}

class RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PersonData person = new PersonData();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  int timeStamp = 0;
  bool _autovalidate = false;
  bool _formWasEdited = false;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('请将注册信息填写完整');
    } else {
      form.save();
      FormData formData = FormData.from({
        "en_name": person.name,
        "email": person.email,
        "mobile": person.phoneNumber,
        "reg_type": 'mobile',
        "password": person.password,
        "repassword": person.password,
        "verify": person.veryCode,
        "mobilecode": person.phoneCode,
      });
      Response response =
          await NetWork().dio.post('/Login/upregister.html', data: formData);
      print(response.request);
      showInSnackBar('${person.name}\'s phone number is ${person.phoneNumber}');
    }
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return '用户名必须';
    final RegExp nameExp = new RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) return '请输入英文用户名';
    return null;
  }

  String _validatePhoneNumber(String value) {
    _formWasEdited = true;
    final RegExp phoneExp = new RegExp(r'^\d{11}$');
    if (!phoneExp.hasMatch(value)) return '手机号码11位数字';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value) return 'The passwords don\'t match';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: const Text('注册未完成'),
              content: const Text('是否离开？'),
              actions: <Widget>[
                new FlatButton(
                  child: const Text('是'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                new FlatButton(
                  child: const Text('否'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        centerTitle: true,
        title: const Text('用户注册'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                new TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: '英文用户名 *',
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (String value) {
                    person.name = value;
                  },
                  validator: _validateName,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: '邮箱',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    person.email = value;
                  },
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: '手机号 *',
                    prefixText: '+86',
                  ),
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (String value) {
                    person.phoneNumber = value;
                  },
                  onSaved: (String value) {
                    person.phoneNumber = value;
                  },
                  validator: _validatePhoneNumber,
                ),
                const SizedBox(height: 24.0),
                Stack(
                  children: <Widget>[
                    new TextFormField(
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: '验证码 *',
                      ),
                      onFieldSubmitted: (String value) {
                        person.veryCode = value;
                      },
                      onSaved: (String value) {
                        person.veryCode = value;
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 180.0,
                        child: GestureDetector(
                            onTap: _handlerVeryCode,
                            child: Image(
                                image: DioImage('/Verify/code?$timeStamp'))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Container(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                    new TextFormField(
                      decoration: const InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: '短信验证码 *',
                      ),
                      onSaved: (String value) {
                        person.phoneCode = value;
                      },
                    ),
                    Container(
//                      margin: EdgeInsets.only(top: 18.0),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _handPhoneCode,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          padding: const EdgeInsets.all(8.0),
                          child: Text('获取短信验证码'),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 24.0),
                new PasswordField(
                  fieldKey: _passwordFieldKey,
                  helperText: '6~16个字符，不含特殊符号',
                  labelText: '登录密码 *',
                  onFieldSubmitted: (String value) {
                    setState(() {
                      person.password = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                new TextFormField(
                  enabled:
                      person.password != null && person.password.isNotEmpty,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: '确认密码',
                  ),
                  maxLength: 16,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24.0),
                new Container(
                  child: new RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('立即注册'),
                    onPressed: _handleSubmitted,
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: <Widget>[
                    new Text('注册即视为同意',
                        style: Theme.of(context).textTheme.caption),
                    GestureDetector(
                      onTap: () {},
                      child: Text(' 《用户注册协议》 ',
                          style: TextStyle(color: Colors.blue)),
                    )
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handPhoneCode() async {
    if (person.phoneNumber.isEmpty) {
      showInSnackBar("请填写手机");
      return;
    }
    if (person.veryCode.isEmpty) {
      showInSnackBar("请先填写验证码");
      return;
    }
    FormData formData = new FormData.from({
      "mobile": person.phoneNumber,
      "verify": person.veryCode,
    });
    Response response =
        await NetWork().dio.post("/Verify/regss", data: formData);
    print(response);
  }

  void _handlerVeryCode() {
    setState(() {
      timeStamp = new DateTime.now().millisecondsSinceEpoch;
    });
  }
}
