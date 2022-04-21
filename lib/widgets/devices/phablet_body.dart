import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/background.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/breakpoints.dart';

class PhabletBody extends StatelessWidget {
  const PhabletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Person').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white70)));
          } else {
            List<dynamic>? person =
            snapshot.data?.docs.map((document) => document.data()).toList();
            return Background(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
                              iconButtonSize: mobileHeaderIconButtonSize,
                              iconButtonSpacerSize: mobileHeaderIconButtonSpacerSize,
                              spacerSize: mobileSpacerSize),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SectionTitle(
                                          title: "PERSONAL INFORMATION",
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize:
                                          mobileSectionTitleUnderlineSize,
                                          spacerSize: mobileSpacerSize),
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
                                      PersonalInfoLocation(
                                          iconSize: mobileIconSize,
                                          label: person[0]["location"],
                                          labelFontSize: mobileLabelFontSize),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      SectionTitle(
                                          title: "SKILLS",
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize:
                                          mobileSectionTitleUnderlineSize,
                                          spacerSize: mobileSpacerSize),
                                      for (var skill in person[0]["skills"])
                                        ProgressionBar(
                                            label: skill["skill"],
                                            progressionBarWidth: mobileProgressionBarWidth,
                                            labelFontSize: mobileLabelFontSize,
                                            progression: skill["percentage"]),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      SectionTitle(
                                          title: "LANGUAGES",
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize:
                                          mobileSectionTitleUnderlineSize,
                                          spacerSize: mobileSpacerSize),
                                      for (var language in person[0]["languages"])
                                        ProgressionBar(
                                            label:
                                            "${language["language"]} (${language["fluency"]})",
                                            progressionBarWidth: mobileProgressionBarWidth,
                                            labelFontSize: mobileLabelFontSize,
                                            progression: language["percentage"]),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.white70,
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SectionTitle(
                                          title: "PROFILE",
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize:
                                          mobileSectionTitleUnderlineSize,
                                          spacerSize: mobileSpacerSize),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      SectionTitle(
                                          title: "PROFESSIONAL EXPERIENCE",
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize:
                                          mobileSectionTitleUnderlineSize,
                                          spacerSize: mobileSpacerSize),
                                      for (var job in person[0]["jobs"])
                                        Job(
                                            iconSize: mobileIconSize,
                                            title: job["title"],
                                            time: "(${job["time"]["start"]} - ${job["time"]["end"]})",
                                            description: job["description"],
                                            labelFontSize: mobileLabelFontSize,
                                            spacerSize: mobileSpacerSize),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      SectionTitle(
                                          title: "EDUCATION",
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize:
                                          mobileSectionTitleUnderlineSize,
                                          spacerSize: mobileSpacerSize),
                                      for (var education in person[0]["education"])
                                        Education(
                                            iconSize: mobileIconSize,
                                            academy: education["academy"],
                                            course: education["course"],
                                            time: "(${education["time"]["start"]} - ${education["time"]["end"]})",
                                            labelFontSize: mobileLabelFontSize,
                                            spacerSize: mobileSpacerSize),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
