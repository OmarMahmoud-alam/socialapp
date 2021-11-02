import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/pages/setting/setting.dart';
import 'package:socialapp/pages/signin/cubitlogin.dart';
import 'package:socialapp/pages/signin/loginState.dart';
import 'package:socialapp/pages/signup/signup.dart';
import 'package:socialapp/shared/sharedwadget.dart';

class Sign extends StatelessWidget {
  final TextEditingController emailcont = TextEditingController();
  final TextEditingController passwordcont = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool ispassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitLogin(),
      child: BlocConsumer<CubitLogin, LoginState>(listener: (context, state) {
        if (state is SocialLoginSuccessState) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => Setting()),
            ModalRoute.withName('/'),
          );
        }
      }, builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login in'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 40.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Login to our browser the hot offers ',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          label: 'email',
                          prefix: Icons.email_outlined,
                          controller: emailcont,
                          type: TextInputType.emailAddress,
                          validate: (s) {
                            if (s!.isEmpty) return 'enter the email pls ';
                          }),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                          label: 'password',
                          prefix: Icons.lock_outline,
                          suffix: CubitLogin.get(context).ispassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          suffixPressed: () {
                            CubitLogin.get(context).changevisiblepassword();
                          },
                          isPassword: CubitLogin.get(context).ispassword,
                          controller: passwordcont,
                          type: TextInputType.visiblePassword,
                          validate: (s) {
                            if (s!.isEmpty) return 'enter the password pls ';
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              CubitLogin.get(context).userLogin(
                                  email: emailcont.text,
                                  password: passwordcont.text);
                            }
                          },
                          text: 'LOGIN IN'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: () {
                                navigateto(context: context, widget: SignUp());
                              },
                              child: Text('Registe now'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
