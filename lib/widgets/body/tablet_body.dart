import 'package:flutter/material.dart';
import 'package:portfolio/widgets/body/body_background.dart';
import 'package:portfolio/widgets/portfolio_widgets.dart';
import 'package:portfolio/breakpoints.dart';

class TabletBody extends StatelessWidget {
  const TabletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(100.0, 50.0, 100.0, 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                    image: "images/nunosilva.jpg",
                    imageSize: tabletHeaderImageSize,
                    name: "Nuno Silva",
                    nameSize: tabletHeaderNameSize,
                    jobTitle: "SOFTWARE DEVELOPER",
                    jobTitleSize: tabletHeaderJobTitleSize,
                    jobTitleSpacing: tabletHeaderJobTitleSpacing,
                    spacerSize: tabletSpacerSize),
                SectionTitle(
                    title: "PERSONAL INFORMATION",
                    titleSize: tabletSectionTitleTitleSize,
                    titleUnderlineSize: tabletSectionTitleTitleUnderlineSize,
                    spacerSize: tabletSectionTitleSpacerSize),
                PersonalInfoNationality(
                    iconSize: tabletIconSize,
                    label: "Portuguese",
                    labelFontSize: tabletLabelFontSize),
                PersonalInfoEmail(
                    iconSize: tabletIconSize,
                    email: "xnunosilva@gmail.com",
                    labelFontSize: tabletLabelFontSize),
                PersonalInfoLinkedIn(
                    iconSize: tabletIconSize,
                    url: "https://www.linkedin.com/in/nunodiogosilva/",
                    urlLabel: "linkedin.com/in/nunodiogosilva",
                    labelFontSize: tabletLabelFontSize),
                PersonalInfoPhoneNumber(
                    iconSize: tabletIconSize,
                    phoneNumber: "+351 936901566",
                    labelFontSize: tabletLabelFontSize),
                const SizedBox(
                  height: 40.0,
                ),
                SectionTitle(
                    title: "SKILLS",
                    titleSize: tabletSectionTitleTitleSize,
                    titleUnderlineSize: tabletSectionTitleTitleUnderlineSize,
                    spacerSize: tabletSectionTitleSpacerSize),
                ProgressionBar(
                    label: "Python",
                    labelFontSize: tabletLabelFontSize,
                    progression: 0.9),
                ProgressionBar(
                    label: "JavaScript",
                    labelFontSize: tabletLabelFontSize,
                    progression: 0.80),
                const SizedBox(
                  height: 40.0,
                ),
                SectionTitle(
                    title: "LANGUAGES",
                    titleSize: tabletSectionTitleTitleSize,
                    titleUnderlineSize: tabletSectionTitleTitleUnderlineSize,
                    spacerSize: tabletSectionTitleSpacerSize),
                ProgressionBar(
                    label: "Portuguese (Native)",
                    labelFontSize: tabletLabelFontSize,
                    progression: 1.0),
                ProgressionBar(
                    label: "English (Fluent)",
                    labelFontSize: tabletLabelFontSize,
                    progression: 0.95),
                const SizedBox(
                  height: 40.0,
                ),
                SectionTitle(
                    title: "PROFESSIONAL EXPERIENCE",
                    titleSize: tabletSectionTitleTitleSize,
                    titleUnderlineSize: tabletSectionTitleTitleUnderlineSize,
                    spacerSize: tabletSectionTitleSpacerSize),
                JobTitle(
                    iconSize: tabletIconSize,
                    jobTitle:
                        "Google Search Feature Quality Specialist & Developer via Qualitest",
                    labelFontSize: tabletIconSize),
                JobDescription(
                    jobDescription:
                        "Member of a sub-group of Search Language Specialists (trusted team partner to Google Search and other Google engineering teams) who leverage end-to-end i18n experience to provide scaled defect triage, release reviews and approval and real-time production feature monitoring.",
                    labelFontSize: tabletLabelFontSize,
                    spacerSize: tabletSpacerSize),
                JobTitle(
                    iconSize: tabletIconSize,
                    jobTitle: "Nokia SoftWare - FullStack Developer",
                    labelFontSize: tabletIconSize),
                JobDescription(
                    jobDescription:
                        "My ultimate goal was to develop a tool that would replace MS Excel from being our day to day tool. Alongside another co-worker we've created a platform where all team's workflows were available. This tool increased work reliability, performance and generated monthly reports and performance statistics for team leaders.",
                    labelFontSize: tabletLabelFontSize,
                    spacerSize: tabletSpacerSize),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
