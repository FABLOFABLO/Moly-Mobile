import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moly_mobile/common/widgets/moly_app_bar.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/common/widgets/moly_text_field.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePasswordMatch);
    _checkPasswordController.addListener(_validatePasswordMatch);
  }

  bool _hasPasswordCheckError = false;

  void _validatePasswordMatch() {
    final password = _passwordController.text;
    final confirmation = _checkPasswordController.text;

    final hasError = confirmation.isNotEmpty && password != confirmation;

    if (_hasPasswordCheckError == hasError) {
      return;
    }

    setState(() {
      _hasPasswordCheckError = hasError;
    });
  }

  @override
  void dispose() {
    _nickNameController.dispose();
    _passwordController.dispose();
    _checkPasswordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MolyScaffold(
        body: Column(
          children: [
            MolyAppBar(type: MolyAppBarType.auth),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 24,),
                        Text('회원가입', style: MolyTextStyle.headline3),
                      ],
                    ),
                    const SizedBox(height: 40,),
                    MolyTextField(
                      text: '비밀번호',
                      hintText: '비밀번호를 입력해주세요',
                      controller: _passwordController,
                      minline: 1,
                    ),
                    const SizedBox(height: 20),
                    MolyTextField(
                      text: '비밀번호 확인',
                      hintText: '비밀번호를 입력해주세요',
                      controller: _checkPasswordController,
                      minline: 1,
                      hasError: _hasPasswordCheckError,
                    ),
                    const SizedBox(height: 305),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MolyButton(
                        label: '다음',
                        onPressed: () => context.push('/signUp3'),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
