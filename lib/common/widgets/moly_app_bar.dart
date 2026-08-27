import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/constants/text_style.dart';

enum MolyAppBarType { auth, standard, memo, memoEdit, myPage }

class MolyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MolyAppBar({
    super.key,
    this.title,
    required this.type,
    this.onBackPressed,
    this.onEditPressed,
    this.onDeletePressed,
    this.onSavePressed,
    this.onSettingsPressed,
  });

  final String? title;

  final MolyAppBarType type;

  final VoidCallback? onBackPressed;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onSavePressed;
  final VoidCallback? onSettingsPressed;

  static const double _standardHeight = 56;
  static const double _authHeight = 76;

  @override
  Size get preferredSize {
    switch (type) {
      case MolyAppBarType.auth:
        return const Size.fromHeight(_authHeight);
      case MolyAppBarType.standard:
      case MolyAppBarType.memo:
      case MolyAppBarType.memoEdit:
      case MolyAppBarType.myPage:
        return const Size.fromHeight(_standardHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MolyAppBarType.auth:
        return _buildAuthAppBar(context);
      case MolyAppBarType.standard:
        return _buildStandardAppBar(context, title: title!);
      case MolyAppBarType.memo:
        return _buildMemoAppBar(context);
      case MolyAppBarType.memoEdit:
        return _buildMemoEditAppBar(context);
      case MolyAppBarType.myPage:
        return _buildMyPageAppBar();
    }
  }

  Widget _buildAuthAppBar(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _authHeight,
          child: Stack(
            children: [
              Positioned(
                left: 25,
                bottom: 4,
                child: _BackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStandardAppBar(BuildContext context, {required String title}) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _standardHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 24,
                child: _BackButton(),
              ),
              Center(child: _Title(title: title)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemoAppBar(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _standardHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 24,
                child: _BackButton(),
              ),
              const Center(child: _Title(title: '메모')),
              Positioned(
                right: 12,
                child: PopupMenuButton<_MemoMenu>(
                  constraints: BoxConstraints(
                    minWidth: 88,
                    maxWidth: 88,
                  ),
                  padding: EdgeInsets.zero,
                  tooltip: '',
                  color: MolyColor.white,
                  elevation: 2,
                  offset: const Offset(-10, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    size: 22,
                    color: MolyColor.gray300,
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case _MemoMenu.edit:
                        onEditPressed?.call();
                        break;

                      case _MemoMenu.delete:
                        onDeletePressed?.call();
                        break;
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: _MemoMenu.edit,
                        height: 27,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SvgAssets.memoEdit),
                            SizedBox(width: 8),
                            Text(
                              '수정',
                              style: MolyTextStyle.captionMedium.copyWith(
                                color: MolyColor.brown100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuDivider(
                        indent: 6,
                        endIndent: 6,
                      ),
                      PopupMenuItem(

                        value: _MemoMenu.delete,
                        height: 27,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SvgAssets.memoDelete),
                            SizedBox(width: 8),
                            Text(
                              '삭제',
                              style: MolyTextStyle.captionMedium.copyWith(
                                color: MolyColor.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemoEditAppBar(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _standardHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 24,
                child: _BackButton(),
              ),
              const Center(child: _Title(title: '메모 수정')),
              Positioned(
                right: 12,
                child: TextButton(
                  onPressed: onSavePressed,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '저장',
                    style: MolyTextStyle.textBold.copyWith(
                      color: MolyColor.brown100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyPageAppBar() {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _standardHeight,
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 7,
                child: IconButton(
                  onPressed: onSettingsPressed,
                  icon: const Icon(
                    Icons.settings_rounded,
                    size: 20,
                    color: MolyColor.brown100,
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

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: SvgPicture.asset(SvgAssets.back),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: MolyTextStyle.textMedium);
  }
}
enum _MemoMenu { edit, delete }
