import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moly_mobile/common/widgets/moly_app_bar.dart';
import 'package:moly_mobile/common/widgets/moly_button.dart';
import 'package:moly_mobile/common/widgets/moly_scaffold.dart';
import 'package:moly_mobile/common/widgets/moly_text_field.dart';
import 'package:moly_mobile/core/constants/text_style.dart';
import 'package:moly_mobile/features/auth/presentation/widgets/pw_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
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
                MolyAppBar(label: '회원가입'),
                Expanded(child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MolyTextField(text: '이메일', hintText: '이메일을 입력해주세요', hasIcon: false, controller: _nickNameController, minline: 1, big: false),
                      const SizedBox(height: 405,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: MolyButton(label: '다음', onPressed: () => context.push('/signUp_2')),
                      ),
                      const SizedBox(height: 50,)
                    ],
                  ),
                ))

              ],
            )
        )
    );
  }
}
