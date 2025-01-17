import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  // Implements PreferredSizeWidget
  final String title;
  final void Function()? onPress;
  final IconData? icon;
  final int? currentIndex;
  final int? totalIndex;
  final TextStyle? titleStyle;
  final bool? rightIcon;
  final void Function()? onTapTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPress,
    this.icon,
    this.currentIndex,
    this.totalIndex,
    this.titleStyle,
    this.rightIcon = false,
    this.onTapTitle,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onTap: widget.onTapTitle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
            ),
            if (widget.rightIcon == true) const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      titleTextStyle: widget.titleStyle ?? TextStyle(color: Colors.black),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: widget.onPress,
        icon: Icon(
          widget.icon,
          size: 24,
          color: Colors.black,
        ),
      ),
      actions: [
        // 오른쪽 텍스트가 존재하는 경우 텍스트를 표시
        if (widget.currentIndex != null && widget.totalIndex != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.currentIndex}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                  TextSpan(
                    text: '/${widget.totalIndex}',
                    style: const TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 14,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
