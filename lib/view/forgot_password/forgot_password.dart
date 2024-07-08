import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/view_model/forgot_password/forgot_pass_controller.dart';
import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/route_name.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
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
                  SizedBox(height: height * .13,),
                  Text("Recover your Seed account",style: Theme.of(context).textTheme.displayMedium,),
                  Image.asset("assets/images/logo.png",width: 100,),
                  SizedBox(height: height * .07,),
                  Text("Enter your email address to\nrecover your Seed account password",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle1,),
                  SizedBox(height: height * .02,),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputTextField(
                            myController: emailController,
                            focusNode: emailFocusNode,
                            onFieldSubmittedValue: (value){
                              // Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                            },
                            onValidator: (validator){
                              return validator.toString().isEmpty? "Enter your email..": null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            hint: "Email",
                            obscureText: false,
                          ),
                        ],
                      )
                  ),
                  SizedBox(height: height * .035,),
                  ChangeNotifierProvider(
                    create: (_)=> ForgotPasswordController(),
                    child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child){
                        return RoundButton(onTap: () {
                          if(_formKey.currentState!.validate()){
                            provider.forgotPassword(context, emailController.text);
                          }
                        },
                          loading: provider.loading,
                          title: "Recover",
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
