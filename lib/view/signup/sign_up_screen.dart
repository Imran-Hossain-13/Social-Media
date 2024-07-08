import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../../view_model/signup_controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                builder: (context, provider, child){
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios,size: 32,),
                            )
                          ],
                        ),
                        SizedBox(height: height * .07,),
                        Text("Welcome to Seed world",style: Theme.of(context).textTheme.displayMedium,),
                        Image.asset("assets/images/logo.png",width: 100,),
                        SizedBox(height: height * .07,),
                        Text("Enter your email address\nto connect with Seed",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge,),
                        SizedBox(height: height * .02,),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                InputTextField(
                                  myController: userNameController,
                                  focusNode: userNameFocusNode,
                                  onFieldSubmittedValue: (value){
                                    Utils.fieldFocus(context, userNameFocusNode, emailFocusNode);
                                  },
                                  onValidator: (validator){
                                    return validator.toString().isEmpty? "Enter username..": null;
                                  },
                                  keyboardType: TextInputType.text,
                                  hint: "Username",
                                  obscureText: false,
                                ),
                                InputTextField(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  onFieldSubmittedValue: (value){
                                    Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                                  },
                                  onValidator: (validator){
                                    return validator.toString().isEmpty? "Enter your email..": null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  hint: "Email",
                                  obscureText: false,
                                ),
                                InputTextField(
                                  myController: passwordController,
                                  focusNode: passwordFocusNode,
                                  onFieldSubmittedValue: (value){

                                  },
                                  onValidator: (validator){
                                    return validator.toString().isEmpty? "Enter your password..": null;
                                  },
                                  keyboardType: TextInputType.text,
                                  hint: "Password",
                                  obscureText: true,
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: height * .035,),
                        RoundButton(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              provider.signup(context,userNameController.text.toString(), emailController.text.toString(), passwordController.text.toString());
                            }
                          },
                          loading: provider.loading,
                          title: "Sign Up",
                        ),
                        SizedBox(height: height * .02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 17,fontWeight: FontWeight.w500),),
                            InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, RouteName.loginView);
                                },
                                child: Text("Signin",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 15,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),)
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ),
          ),
        ),
      ),
    );
  }
}
