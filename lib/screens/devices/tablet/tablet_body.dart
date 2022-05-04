import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

            person![0]["jobs"].sort((a, b) {
              return DateTime.parse(b["time"]["start"].toDate().toString()).compareTo(DateTime.parse(a["time"]["start"].toDate().toString()));
            });

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
                              name: person[0]["name"],
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
                                      PersonalInfo(
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize: tabletSectionTitleUnderlineSize,
                                          iconSize: desktopIconSize,
                                          nationality: person[0]["nationality"],
                                          email: person[0]["email"],
                                          linkedInUrl: person[0]["linkedIn"]["url"],
                                          linkedInLabel: person[0]["linkedIn"]["label"],
                                          phoneNumber: person[0]["phoneNumber"],
                                          locationLabel: person[0]["location"]["label"],
                                          locationUrl: person[0]["location"]["url"],
                                          labelFontSize: tabletLabelFontSize,
                                          spacerSize: tabletSpacerSize,
                                          widgetSpacerSize: tabletWidgetSpacerSize),
                                      SkillsSectionTitle(
                                          iconButtonSize: tabletHeaderIconButtonSize,
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      for (var skill in person[0]["skills"])
                                        ProgressionBar(
                                            label: skill["skill"],
                                            progressionBarWidth: tabletProgressionBarWidth,
                                            labelFontSize: tabletLabelFontSize,
                                            progression: skill["percentage"],
                                            spacerSize: tabletSpacerSize),
                                      SizedBox(
                                        height: tabletSpacerSize,
                                      ),
                                      LanguagesSectionTitle(
                                          iconButtonSize: mobileHeaderIconButtonSize,
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
                                            progression: language["percentage"],
                                            spacerSize: tabletSpacerSize),
                                      SizedBox(
                                        height: tabletSpacerSize,
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
                                      Profile(
                                        titleSize: tabletSectionTitleSize,
                                        titleUnderlineSize: tabletSectionTitleUnderlineSize,
                                        profile: person[0]["profile"],
                                        labelFontSize: tabletLabelFontSize,
                                        spacerSize: tabletSpacerSize,
                                        widgetSpacerSize: tabletWidgetSpacerSize
                                      ),
                                      JobSectionTitle(
                                          iconButtonSize: tabletHeaderIconButtonSize,
                                          titleSize: tabletSectionTitleSize,
                                          titleUnderlineSize:
                                          tabletSectionTitleUnderlineSize,
                                          spacerSize: tabletSpacerSize),
                                      for (var job in person[0]["jobs"])
                                        Job(
                                            iconSize: tabletIconSize,
                                            title: job["title"],
                                            timeStart: DateTime.parse(job["time"]["start"].toDate().toString()),
                                            timeEnd: DateTime.parse(job["time"]["end"].toDate().toString()),
                                            description: job["description"],
                                            labelFontSize: tabletLabelFontSize,
                                            spacerSize: tabletSpacerSize),
                                      SizedBox(
                                        height: tabletSpacerSize,
                                      ),
                                      EducationSectionTitle(
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
                                      SizedBox(
                                        height: tabletSpacerSize,
                                      ),
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
