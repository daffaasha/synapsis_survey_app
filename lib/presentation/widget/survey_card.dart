import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:synapsis_survey_app/config/theme/color.dart';
import 'package:synapsis_survey_app/config/theme/dimens.dart';
import 'package:synapsis_survey_app/domain/entities/survey.dart';

class SurveyCard extends StatelessWidget {
  final SurveyEntity survey;
  final void Function(String)? onClick;

  const SurveyCard({required this.survey, required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick?.call(survey.surveyId!);
      },
      child: Padding(
        padding: const EdgeInsets.only(
            right: mediumPadding1, left: mediumPadding1, top: smallPadding1),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: softGray3, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: smallPadding2, horizontal: smallPadding3),
            child: Row(
              children: [
                CachedNetworkImage(
                  height: 70,
                  width: 70,
                  imageUrl: survey.surveyImage!,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: smallPadding2,
                ),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(survey.surveyName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                        Text(
                          "Created At: ${_parseDate(survey.createdAt!)}",
                          style: Theme.of(context).textTheme.bodyMedium?.apply(
                                color: green,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _parseDate(String date) {
    final dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(dateTime);
  }
}
