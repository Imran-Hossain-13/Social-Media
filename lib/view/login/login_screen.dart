import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../../view_model/login_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height * .13,),
                  Text("Welcome to Seed world",style: Theme.of(context).textTheme.displayMedium,),
                  Image.asset("assets/images/logo.png",width: 100,),
                  SizedBox(height: height * .07,),
                  Text("Enter your email and password\nto connect with your Seed account",textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: height * .02,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RouteName.forgotPasswordScreen);
                      },
                      child: Text("Forgot password?",style: Theme.of(context).textTheme.bodyLarge!.copyWith(decoration: TextDecoration.underline),),
                    ),
                  ),
                  SizedBox(height: height * .035,),
                  ChangeNotifierProvider(
                    create: (_)=> LoginController(),
                    child: Consumer<LoginController>(
                      builder: (context, provider, child){
                        return RoundButton(onTap: () {
                          if(_formKey.currentState!.validate()){
                            provider.login(context, emailController.text, passwordController.text);
                          }
                        },
                        loading: provider.loading,
                        title: "Login",
                        );
                      },
                    ),
                  ),
                  SizedBox(height: height * .02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 17,fontWeight: FontWeight.w500),),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RouteName.signupScreen);
                        },
                          child: Text("Sign Up",style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 15,fontWeight: FontWeight.w700,decoration: TextDecoration.underline),)
                      )
                    ],
                  ),
                  /**Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 17,fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15,fontWeight: FontWeight.w700,decoration: TextDecoration.underline)
                        ),
                      ]
                    ),
                  ),**/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
