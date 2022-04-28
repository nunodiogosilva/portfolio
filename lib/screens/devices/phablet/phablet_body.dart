import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                                      PersonalInfo(
                                          titleSize: mobileSectionTitleSize,
                                          titleUnderlineSize: mobileSectionTitleUnderlineSize,
                                          iconSize: desktopIconSize,
                                          nationality: person[0]["nationality"],
                                          email: person[0]["email"],
                                          linkedInUrl: person[0]["linkedIn"]["url"],
                                          linkedInLabel: person[0]["linkedIn"]["label"],
                                          phoneNumber: person[0]["phoneNumber"],
                                          locationLabel: person[0]["location"]["label"],
                                          locationUrl: person[0]["location"]["url"],
                                          labelFontSize: mobileLabelFontSize,
                                          spacerSize: mobileSpacerSize),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      SkillsSectionTitle(
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
                                      LanguagesSectionTitle(
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
                                      Profile(
                                        titleSize: mobileSectionTitleSize,
                                        titleUnderlineSize: mobileSectionTitleUnderlineSize,
                                        profile: person[0]["profile"],
                                        labelFontSize: mobileLabelFontSize,
                                        spacerSize: mobileSpacerSize,
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      JobSectionTitle(
                                          iconButtonSize: mobileHeaderIconButtonSize,
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
                                      EducationSectionTitle(
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
