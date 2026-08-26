import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_app_bar.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/common/widgets/moly_text_field.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _nickNameController.dispose();
    _passwordController.dispose();
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
            MolyAppBar(label: '로그인'),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MolyTextField(
                        text: '닉네임',
                        hintText: '닉네임을 입력해주세요',
                        controller: _nickNameController,
                        minline: 1,
                      ),
                      const SizedBox(height: 20),
                      MolyTextField(
                        text: '비밀번호',
                        hintText: '비밀번호를 입력해주세요',
                        controller: _passwordController,
                        minline: 1,
                        hasIcon: true,
                      ),
                      const SizedBox(height: 300),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: MolyButton(label: '로그인', onPressed: () {}),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ))

          ],
        ),
      ),
    );
  }
}
