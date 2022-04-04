import 'package:flutter/material.dart';
import 'package:portfolio/widgets/body/body_background.dart';
import 'package:portfolio/widgets/portfolio_widgets.dart';
import 'package:portfolio/breakpoints.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                      image: "images/nunosilva.jpg",
                      imageSize: mobileHeaderImageSize,
                      name: "Nuno Silva",
                      nameSize: mobileHeaderNameSize,
                      jobTitle: "SOFTWARE DEVELOPER",
                      jobTitleSize: mobileHeaderJobTitleSize,
                      jobTitleSpacing: mobileHeaderJobTitleSpacing,
                      spacerSize: mobileSpacerSize),
                  SectionTitle(
                      title: "PERSONAL INFORMATION",
                      titleSize: mobileSectionTitleTitleSize,
                      titleUnderlineSize: mobileSectionTitleTitleUnderlineSize,
                      spacerSize: mobileSectionTitleSpacerSize),
                  PersonalInfoNationality(
                      iconSize: mobileIconSize,
                      label: "Portuguese",
                      labelFontSize: mobileLabelFontSize),
                  PersonalInfoEmail(
                      iconSize: mobileIconSize,
                      email: "xnunosilva@gmail.com",
                      labelFontSize: mobileLabelFontSize),
                  PersonalInfoLinkedIn(
                      iconSize: mobileIconSize,
                      url: "https://www.linkedin.com/in/nunodiogosilva/",
                      urlLabel: "linkedin.com/in/nunodiogosilva",
                      labelFontSize: mobileLabelFontSize),
                  PersonalInfoPhoneNumber(
                      iconSize: mobileIconSize,
                      phoneNumber: "+351 936901566",
                      labelFontSize: mobileLabelFontSize),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SectionTitle(
                      title: "SKILLS",
                      titleSize: mobileSectionTitleTitleSize,
                      titleUnderlineSize: mobileSectionTitleTitleUnderlineSize,
                      spacerSize: mobileSectionTitleSpacerSize),
                  ProgressionBar(
                      label: "Python",
                      labelFontSize: mobileLabelFontSize,
                      progression: 0.9),
                  ProgressionBar(
                      label: "JavaScript",
                      labelFontSize: mobileLabelFontSize,
                      progression: 0.80),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SectionTitle(
                      title: "LANGUAGES",
                      titleSize: mobileSectionTitleTitleSize,
                      titleUnderlineSize: mobileSectionTitleTitleUnderlineSize,
                      spacerSize: mobileSectionTitleSpacerSize),
                  ProgressionBar(
                      label: "Portuguese (Native)",
                      labelFontSize: mobileLabelFontSize,
                      progression: 1.0),
                  ProgressionBar(
                      label: "English (Fluent)",
                      labelFontSize: mobileLabelFontSize,
                      progression: 0.95),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SectionTitle(
                      title: "PROFESSIONAL EXPERIENCE",
                      titleSize: mobileSectionTitleTitleSize,
                      titleUnderlineSize: mobileSectionTitleTitleUnderlineSize,
                      spacerSize: mobileSectionTitleSpacerSize),
                  JobTitle(
                      iconSize: mobileIconSize,
                      jobTitle:
                          "Google Search Feature Quality Specialist & Developer via Qualitest",
                      labelFontSize: mobileIconSize),
                  JobDescription(
                      jobDescription:
                          "Member of a sub-group of Search Language Specialists (trusted team partner to Google Search and other Google engineering teams) who leverage end-to-end i18n experience to provide scaled defect triage, release reviews and approval and real-time production feature monitoring.",
                      labelFontSize: mobileLabelFontSize,
                      spacerSize: mobileSpacerSize),
                  JobTitle(
                      iconSize: mobileIconSize,
                      jobTitle: "Nokia SoftWare - FullStack Developer",
                      labelFontSize: mobileIconSize),
                  JobDescription(
                      jobDescription:
                          "My ultimate goal was to develop a tool that would replace MS Excel from being our day to day tool. Alongside another co-worker we've created a platform where all team's workflows were available. This tool increased work reliability, performance and generated monthly reports and performance statistics for team leaders.",
                      labelFontSize: mobileLabelFontSize,
                      spacerSize: mobileSpacerSize),
                  const SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
