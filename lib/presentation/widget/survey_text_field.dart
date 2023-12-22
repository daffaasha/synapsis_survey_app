import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';
import 'package:synapsis_survey_app/presentation/bloc/login_page_bloc/login_bloc/login_bloc.dart';

class SurveyTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool? isPassword;
  final bool? isPasswordVisible;
  final double? topPadding;
  final Function(String) onChanged;

  const SurveyTextField(
    this.onChanged, {
    super.key,
    this.hintText = "",
    this.labelText = "",
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.topPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding),
        Text(
          labelText!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: softGray,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 44,
          child: TextField(
            obscureText: !isPassword! ? false : !isPasswordVisible!,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              filled: true,
              fillColor: softGray2,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: softBlue,
                    width: 1,
                  )),
              hintText: hintText,
              suffixIcon: isPassword! ? _buildSuffixIcon() : null,
            ),
          ),
        ),
      ],
    );
  }

  _buildSuffixIcon() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context
                .read<LoginBloc>()
                .add(PasswordVisibilityChanged(!state.isPasswordVisible));
          },
          icon: Icon(
            state.isPasswordVisible == false
                ? Icons.visibility_off
                : Icons.visibility,
            color: softGray,
          ),
        );
      },
    );
  }
}
