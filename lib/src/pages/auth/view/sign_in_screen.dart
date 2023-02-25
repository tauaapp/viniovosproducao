// ignore_for_file: body_might_complete_normally_nullable, curly_braces_in_flow_control_structures

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:viniovos/src/config/custom_colors.dart';
import 'package:viniovos/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:viniovos/src/pages/auth/view/sign_up_screen.dart';
import 'package:viniovos/src/pages/common_widgets/app_name_widget.dart';
import 'package:viniovos/src/pages/common_widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:viniovos/src/services/utils_services.dart';

import '../controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final emailController = TextEditingController();
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nome do app
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),

                    // Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText(
                              'Ovos Branco',
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            FadeAnimatedText(
                              'Ovos Vermelho',
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            FadeAnimatedText(
                              'Refrigerantes',
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Formulário
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email
                      CustomTextField(
                        controller: phonecontroller,
                        icon: Icons.phone,
                        label: 'Telefone',
                        validator: (phone) {
                          if (phone == null || phone.isEmpty) {
                            return "Digite seu telefone";
                          }
                          if (!phone.isPhoneNumber) {
                            return "Digite seu telefone";
                          }
                          return null;
                        },
                      ),

                      // Senha
                      CustomTextField(
                          controller: passwordcontroller,
                          icon: Icons.lock,
                          label: 'Senha',
                          isSecret: true,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return "Digite sua senha";
                            }
                            if (password.length < 6) {
                              return "Digite uma senha com pelo menos 6 caracteres ";
                            }
                            return null;
                          }),

                      // Botão de entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (authcontroller) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: authcontroller.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        // ignore: unused_local_variable
                                        String phone = phonecontroller.text;
                                        // ignore: unused_local_variable
                                        String password =
                                            passwordcontroller.text;
                                        // ignore: avoid_print
                                        // print(
                                        //     'Telefone = $phone - Senha = $passwordcontroller');
                                        authcontroller.signIn(
                                            phone: phone, password: password);
                                      }
                                    },
                              child: authcontroller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),

                      // Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_) {
                                return ForgotPasswordDialog(
                                  email: emailController.text,
                                );
                              },
                            );

                            if (result ?? false) {
                              utilsServices.showToast(
                                message:
                                    'Um link de recuperação foi enviado para seu email.',
                              );
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),

                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botão de novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) {
                                  return SignUpScreen();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
