import 'package:flutter/material.dart';
import 'package:moly_mobile/common/widgets/moly_app_bar.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/common/widgets/moly_text_field.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

class SignUpPage3 extends StatefulWidget {
  const SignUpPage3({super.key});

  @override
  State<SignUpPage3> createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  final TextEditingController _nickNameController = TextEditingController();

  @override
  void dispose() {
    _nickNameController.dispose();
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
                      text: '사용자 닉네임',
                      hintText: '사용자 닉네임을 입력해주세요',
                      controller: _nickNameController,
                      minline: 1,
                    ),
                    const SizedBox(height: 405),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MolyButton(label: '회원가입', onPressed: () {}),
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
