import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/shared/widgets/dialogs/custom_info_dialog.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class AyahNumberPickerDialog extends StatefulWidget {
  final String title;
  final int value;
  final int minValue;
  final int maxValue;

  const AyahNumberPickerDialog({
    super.key,
    required this.title,
    required this.value,
    required this.minValue,
    required this.maxValue,
  });

  @override
  State<AyahNumberPickerDialog> createState() => _AyahNumberPickerDialogState();
}

class _AyahNumberPickerDialogState extends State<AyahNumberPickerDialog> {
  late int? selectedAyah = widget.value;

  bool get isValid =>
      selectedAyah != null &&
      selectedAyah! >= widget.minValue &&
      selectedAyah! <= widget.maxValue;

  void submit() {
    if (!isValid) return;

    Navigator.of(context).pop<int>(selectedAyah);
  }

  @override
  Widget build(BuildContext context) {
    return CustomInfoDialog(
      secondaryButtonText: MaterialLocalizations.of(context).closeButtonLabel,
      secondaryIcon: Icons.close_rounded,
      onSecondaryPressed: () => Navigator.of(context).pop(),
      title: widget.title,
      icon: Icons.edit_note_outlined,
      content: TextFormField(
        initialValue: widget.value.toString(),
        autofocus: true,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursorColor: AppColors.primary,
        style: AppTextStyles.body16.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.black.withValues(alpha: 0.22),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          helperText: '${widget.minValue} – ${widget.maxValue}',
          helperStyle: AppTextStyles.body10.copyWith(
            color: AppColors.white.withValues(alpha: 0.5),
          ),
          helperMaxLines: 1,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5.w),
          ),
        ),
        onChanged: (text) {
          setState(() {
            selectedAyah = int.tryParse(text);
          });
        },
        onFieldSubmitted: (_) => submit(),
      ),

      buttonText: MaterialLocalizations.of(context).okButtonLabel,
      onPressed: submit,
      isEnabled: isValid,
    );
  }
}
