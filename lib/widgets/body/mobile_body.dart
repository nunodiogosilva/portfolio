import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/body/body_background.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/breakpoints.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Person').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const BodyBackground(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white70)));
          } else {
            List<dynamic>? person =
                snapshot.data?.docs.map((document) => document.data()).toList();
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
                              name: person![0]["name"],
                              nameSize: mobileHeaderNameSize,
                              jobTitle: person[0]["jobTitle"].toUpperCase(),
                              jobTitleSize: mobileHeaderJobTitleSize,
                              jobTitleSpacing: mobileHeaderJobTitleSpacing,
                              spacerSize: mobileSpacerSize),
                          SectionTitle(
                              title: "PERSONAL INFORMATION",
                              titleSize: mobileSectionTitleTitleSize,
                              titleUnderlineSize:
                                  mobileSectionTitleTitleUnderlineSize,
                              spacerSize: mobileSectionTitleSpacerSize),
                          PersonalInfoNationality(
                              iconSize: mobileIconSize,
                              label: person[0]["nationality"],
                              labelFontSize: mobileLabelFontSize),
                          PersonalInfoEmail(
                              iconSize: mobileIconSize,
                              email: person[0]["email"],
                              labelFontSize: mobileLabelFontSize),
                          PersonalInfoLinkedIn(
                              iconSize: mobileIconSize,
                              url: person[0]["linkedIn"]["url"],
                              label: person[0]["linkedIn"]["label"],
                              labelFontSize: mobileLabelFontSize),
                          PersonalInfoPhoneNumber(
                              iconSize: mobileIconSize,
                              phoneNumber: person[0]["phoneNumber"],
                              labelFontSize: mobileLabelFontSize),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SectionTitle(
                              title: "SKILLS",
                              titleSize: mobileSectionTitleTitleSize,
                              titleUnderlineSize:
                                  mobileSectionTitleTitleUnderlineSize,
                              spacerSize: mobileSectionTitleSpacerSize),
                          for (var skill in person[0]["skills"])
                            ProgressionBar(
                                label: skill["skill"],
                                labelFontSize: mobileLabelFontSize,
                                progression: skill["percentage"]),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SectionTitle(
                              title: "LANGUAGES",
                              titleSize: mobileSectionTitleTitleSize,
                              titleUnderlineSize:
                                  mobileSectionTitleTitleUnderlineSize,
                              spacerSize: mobileSectionTitleSpacerSize),
                          for (var language in person[0]["languages"])
                            ProgressionBar(
                                label:
                                "${language["language"]} (${language["fluency"]})",
                                labelFontSize: mobileLabelFontSize,
                                progression: language["percentage"]),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SectionTitle(
                              title: "PROFESSIONAL EXPERIENCE",
                              titleSize: mobileSectionTitleTitleSize,
                              titleUnderlineSize:
                                  mobileSectionTitleTitleUnderlineSize,
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
        });
  }
}
