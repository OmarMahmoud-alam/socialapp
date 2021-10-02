import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/pages/signin/login.dart';
import 'package:socialapp/pages/signup/cubitsignup.dart';
import 'package:socialapp/pages/signup/signupState.dart';

import 'package:socialapp/shared/sharedwadget.dart';

class SignUp extends StatelessWidget {
  final TextEditingController namecont = TextEditingController();
  final TextEditingController phonecont = TextEditingController();
  final TextEditingController passwordcont2 = TextEditingController();
  final TextEditingController emailcont = TextEditingController();
  final TextEditingController passwordcont = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool ispassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitSignup(),
      child: BlocConsumer<CubitSignup, SignupState>(
          listener: (context, state) {},
          builder: (context, state) {
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
                            'sign up'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'signup to our social app THE BEST EVER ',
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                              label: 'name',
                              prefix: Icons.person_add_alt_1_outlined,
                              controller: namecont,
                              type: TextInputType.text,
                              validate: (s) {
                                if (s!.isEmpty) return 'enter the name pls ';
                              }),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                              label: 'phone',
                              prefix: Icons.phone,
                              controller: phonecont,
                              type: TextInputType.phone,
                              validate: (s) {
                                if (s!.isEmpty) return 'enter the phone pls ';
                              }),
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
                              suffix: CubitSignup.get(context).ispassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              suffixPressed: () {
                                CubitSignup.get(context)
                                    .changevisiblepassword();
                              },
                              isPassword: CubitSignup.get(context).ispassword,
                              controller: passwordcont,
                              type: TextInputType.visiblePassword,
                              validate: (s) {
                                if (s!.isEmpty)
                                  return 'enter the password pls ';
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              label: 'conform password',
                              prefix: Icons.lock_outline,
                              suffix: CubitSignup.get(context).ispassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              suffixPressed: () {
                                CubitSignup.get(context)
                                    .changevisiblepassword();
                              },
                              isPassword: CubitSignup.get(context).ispassword,
                              controller: passwordcont2,
                              type: TextInputType.visiblePassword,
                              validate: (s) {
                                if (s!.isEmpty)
                                  return 'enter the password pls ';
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          (state != SignupLoadingState())
                              ? defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      print(emailcont.text);
                                      print(passwordcont.text);

                                      CubitSignup.get(context).usersignup(
                                          email: emailcont.text,
                                          password: passwordcont.text,
                                          name: namecont.text,
                                          phone: phonecont.value);
                                    }
                                  },
                                  text: 'SIGN UP')
                              : CircularProgressIndicator(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('already have acount'),
                              TextButton(
                                  onPressed: () {
                                    navigateto(
                                        context: context, widget: Sign());
                                  },
                                  child: Text('sign in'))
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
