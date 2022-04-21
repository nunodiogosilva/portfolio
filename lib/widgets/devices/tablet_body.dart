import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/background.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/breakpoints.dart';

class TabletBody extends StatelessWidget {
  const TabletBody({Key? key}) : super(key: key);

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
                    padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Header(
                              image: "images/nunosilva.jpg",
                              imageSize: tabletHeaderImageSize,
                              name: person![0]["name"],
                              nameSize: tabletHeaderNameSize,
                              jobTitle: person[0]["jobTitle"].toUpperCase(),
                              jobTitleSize: tabletHeaderJobTitleSize,
                              jobTitleSpacing: tabletHeaderJobTitleSpacing,
                              iconButtonSize: tabletHeaderIconButtonSize,
                              iconButtonSpacerSize: tabletHeaderIconButtonSpacerSize,
                              spacerSize: tabletSpacerSize),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SectionTitle(
                                          title: "PERSONAL INFORMATION",
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      PersonalInfoNationality(
                                          iconSize: tabletIconSize,
                                          label: person[0]["nationality"],
                                          labelFontSize: tabletLabelFontSize),
                                      PersonalInfoEmail(
                                          iconSize: tabletIconSize,
                                          email: person[0]["email"],
                                          labelFontSize: tabletLabelFontSize),
                                      PersonalInfoLinkedIn(
                                          iconSize: tabletIconSize,
                                          url: person[0]["linkedIn"]["url"],
                                          label: person[0]["linkedIn"]["label"],
                                          labelFontSize: tabletLabelFontSize),
                                      PersonalInfoPhoneNumber(
                                          iconSize: tabletIconSize,
                                          phoneNumber: person[0]["phoneNumber"],
                                          labelFontSize: tabletLabelFontSize),
                                      PersonalInfoLocation(
                                          iconSize: tabletIconSize,
                                          label: person[0]["location"],
                                          labelFontSize: tabletLabelFontSize),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      SectionTitle(
                                          title: "SKILLS",
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      for (var skill in person[0]["skills"])
                                        ProgressionBar(
                                            label: skill["skill"],
                                            progressionBarWidth: tabletProgressionBarWidth,
                                            labelFontSize: tabletLabelFontSize,
                                            progression: skill["percentage"]),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      SectionTitle(
                                          title: "LANGUAGES",
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      for (var language in person[0]["languages"])
                                        ProgressionBar(
                                            label:
                                            "${language["language"]} (${language["fluency"]})",
                                            progressionBarWidth: tabletProgressionBarWidth,
                                            labelFontSize: tabletLabelFontSize,
                                            progression: language["percentage"]),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
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
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      SectionTitle(
                                          title: "PROFESSIONAL EXPERIENCE",
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      for (var job in person[0]["jobs"])
                                        Job(
                                            iconSize: tabletIconSize,
                                            title: job["title"],
                                            time: "(${job["time"]["start"]} - ${job["time"]["end"]})",
                                            description: job["description"],
                                            labelFontSize: tabletLabelFontSize,
                                            spacerSize: tabletSpacerSize),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      SectionTitle(
                                          title: "EDUCATION",
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      for (var education in person[0]["education"])
                                        Education(
                                            iconSize: tabletIconSize,
                                            academy: education["academy"],
                                            course: education["course"],
                                            time: "(${education["time"]["start"]} - ${education["time"]["end"]})",
                                            labelFontSize: tabletLabelFontSize,
                                            spacerSize: tabletSpacerSize),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 100.0,
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
