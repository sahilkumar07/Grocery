import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:grocery/firebase_consts.dart';
import 'package:grocery/strings.dart';
import 'package:grocery/auth_controller.dart';
import 'package:grocery/home_screen.dart';
import 'package:grocery/widgets_common/applogo_widget.dart';
import 'package:grocery/widgets_common/bg_widget.dart';
import 'package:grocery/widgets_common/our_button.dart';
import 'package:grocery/widgets_common/custom_TextField.dart';

const Color fontGrey = Color.fromRGBO(107, 115, 119, 1);
const Color redColor = Color.fromRGBO(230, 46, 4, 1);
const Color whiteColor = Color.fromRGBO(255, 255, 255, 1);
const Color lightGrey = Color.fromRGBO(230, 230, 230, 1);

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  var mobileController = TextEditingController();
  var addressController = TextEditingController();

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordRetypeValid = true;
  bool isMobileValid = true;
  bool isAddressValid = true;

  bool areFieldsFilled() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        emailController.text.contains('@') &&
        passwordController.text.isNotEmpty &&
        passwordController.text == passwordRetypeController.text &&
        mobileController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        isCheck == true;
  }

  void validateFields() {
    setState(() {
      isNameValid = nameController.text.isNotEmpty;
      isEmailValid =
          emailController.text.isNotEmpty && emailController.text.contains('@');
      isPasswordValid = passwordController.text.isNotEmpty;
      isPasswordRetypeValid =
          passwordController.text == passwordRetypeController.text;
      isMobileValid = mobileController.text.isNotEmpty;
      isAddressValid = addressController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: bgWidget(
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      applogowidget(),
                      10.heightBox,
                      "Join the $appname"
                          .text
                          .fontFamily("sans_bold")
                          .size(18)
                          .make(),
                      15.heightBox,
                      Obx(() => Column(
                            children: [
                              customTextField(
                                hint: nameHint,
                                title: name,
                                controller: nameController,
                                isPass: false,
                                errorText:
                                    isNameValid ? null : "Name cannot be empty",
                                prefixIcon: Icons.person,
                              ),
                              customTextField(
                                hint: emailHint,
                                title: email,
                                controller: emailController,
                                isPass: false,
                                errorText: isEmailValid
                                    ? null
                                    : "Please enter a valid email",
                                prefixIcon: Icons.email,
                              ),
                              customTextField(
                                hint: passwordHint,
                                title: password,
                                controller: passwordController,
                                isPass: true,
                                errorText: isPasswordValid
                                    ? null
                                    : "Password cannot be empty",
                                prefixIcon: Icons.lock,
                              ),
                              customTextField(
                                hint: retypePassword,
                                title: 'Retype Password',
                                controller: passwordRetypeController,
                                isPass: true,
                                errorText: isPasswordRetypeValid
                                    ? null
                                    : "Passwords do not match",
                                prefixIcon: Icons.lock_outline,
                              ),
                              customTextField(
                                hint: '123-456-7890',
                                title: 'Mobile Number',
                                controller: mobileController,
                                isPass: false,
                                errorText: isMobileValid
                                    ? null
                                    : "Mobile number cannot be empty",
                                prefixIcon: Icons.phone,
                              ),
                              customTextField(
                                hint: 'Enter your address',
                                title: 'Address',
                                controller: addressController,
                                isPass: false,
                                errorText: isAddressValid
                                    ? null
                                    : "Address cannot be empty",
                                prefixIcon: Icons.home,
                              ),
                              5.heightBox,
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: forgetPass.text.make(),
                                ),
                              ),
                              10.heightBox,
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: whiteColor,
                                    activeColor: redColor,
                                    value: isCheck,
                                    onChanged: (newValue) {
                                      setState(() {
                                        if (areFieldsFilled()) {
                                          isCheck = newValue;
                                        } else {
                                          isCheck = false;
                                          VxToast.show(context,
                                              msg:
                                                  'Please fill all fields correctly');
                                        }
                                      });
                                    },
                                  ),
                                  10.widthBox,
                                  Expanded(
                                    child: RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "I agree to the ",
                                            style: TextStyle(
                                              fontFamily: "sans_regular",
                                              color: fontGrey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: termAndCond,
                                            style: TextStyle(
                                              fontFamily: "sans_regular",
                                              color: redColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " & ",
                                            style: TextStyle(
                                              fontFamily: "sans_bold",
                                              color: fontGrey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: privacypolicy,
                                            style: TextStyle(
                                              fontFamily: "sans_regular",
                                              color: redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.heightBox,
                              controller.isloading.value
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(redColor),
                                    )
                                  : OurButton(
                                      color: areFieldsFilled()
                                          ? redColor
                                          : lightGrey,
                                      title: signup,
                                      textColor: whiteColor,
                                      onPress: () async {
                                        validateFields();
                                        if (areFieldsFilled()) {
                                          controller.isloading(true);
                                          try {
                                            await controller
                                                .signupMethod(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    name: nameController.text,
                                                    context: context,
                                                    mobile:
                                                        mobileController.text,
                                                    address:
                                                        addressController.text)
                                                .then((value) {
                                              return controller.storeUserData(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                  name: nameController.text,
                                                  mobile: mobileController.text,
                                                  address:
                                                      addressController.text);
                                            }).then((value) {
                                              VxToast.show(context,
                                                  msg: loggedin);
                                              Get.offAll(() => Home());
                                            });
                                          } catch (e) {
                                            auth.signOut();
                                            VxToast.show(context,
                                                msg: e.toString());
                                            controller.isloading(false);
                                          }
                                        } else {
                                          VxToast.show(context,
                                              msg: 'Please fill all fields');
                                        }
                                      },
                                    )
                                      .box
                                      .width(context.screenWidth - 50)
                                      .make(),
                              15.heightBox,
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: alreadyHaveaccount,
                                      style: TextStyle(
                                          fontFamily: "sans_bold",
                                          color: fontGrey),
                                    ),
                                    TextSpan(
                                      text: login,
                                      style: TextStyle(
                                          fontFamily: "sans_bold",
                                          color: redColor),
                                    ),
                                  ],
                                ),
                              ).onTap(() {
                                Get.back();
                              }),
                              10.heightBox,
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
