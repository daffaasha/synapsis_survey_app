import 'package:flutter/material.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';

class SurveyPrimaryButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final void Function()? onClick;

  const SurveyPrimaryButton({
    Key? key,
    this.text = "",
    this.width = double.infinity,
    this.height = 50,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
