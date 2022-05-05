import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/breakpoints.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({Key? key}) : super(key: key);

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Person').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else {
            List<dynamic>? person =
                snapshot.data?.docs.map((document) => document.data()).toList();

            person![0]["skills"].sort((a, b) {
              return double.parse(b["percentage"]).compareTo(double.parse(a["percentage"]));
            });

            person[0]["jobs"].sort((a, b) {
              return DateTime.parse(b["time"]["end"].toDate().toString()).compareTo(DateTime.parse(a["time"]["end"].toDate().toString()));
            });

            person[0]["education"].sort((a, b) {
              return DateTime.parse(b["time"]["end"].toDate().toString()).compareTo(DateTime.parse(a["time"]["end"].toDate().toString()));
            });

            person[0]["languages"].sort((a, b) {
              return double.parse(b["percentage"]).compareTo(double.parse(a["percentage"]));
            });

            return Background(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 30.0, 80.0, 30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(
                            image: person[0]["image"],
                            imageSize: desktopHeaderImageSize,
                            name: person[0]["name"],
                            nameSize: desktopHeaderNameSize,
                            jobTitle: person[0]["jobTitle"].toUpperCase(),
                            jobTitleSize: desktopHeaderJobTitleSize,
                            jobTitleSpacing: desktopHeaderJobTitleSpacing,
                            iconButtonSize: desktopHeaderIconButtonSize,
                            iconButtonSpacerSize:
                                desktopHeaderIconButtonSpacerSize,
                            spacerSize: desktopSpacerSize),
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
                                        titleSize: desktopSectionTitleSize,
                                        titleUnderlineSize: desktopSectionTitleUnderlineSize,
                                        iconSize: desktopIconSize,
                                        nationality: person[0]["nationality"],
                                        email: person[0]["email"],
                                        linkedInUrl: person[0]["linkedIn"]["url"],
                                        linkedInLabel: person[0]["linkedIn"]["label"],
                                        phoneNumber: person[0]["phoneNumber"],
                                        locationLabel: person[0]["location"]["label"],
                                        locationUrl: person[0]["location"]["url"],
                                        labelFontSize: desktopLabelFontSize,
                                        spacerSize: desktopSpacerSize,
                                        widgetSpacerSize: desktopWidgetSpacerSize),
                                    SkillsSectionTitle(
                                        iconButtonSize: desktopHeaderIconButtonSize,
                                        titleSize: desktopSectionTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleUnderlineSize,
                                        spacerSize: desktopSpacerSize),
                                    for (var skill in person[0]["skills"])
                                      Skills(
                                          label: skill["skill"],
                                          progressionBarWidth:
                                              desktopProgressionBarWidth,
                                          labelFontSize: desktopLabelFontSize,
                                          progression: skill["percentage"],
                                          spacerSize: desktopSpacerSize),
                                    SizedBox(
                                      height: desktopSpacerSize,
                                    ),
                                    LanguagesSectionTitle(
                                        iconButtonSize: desktopHeaderIconButtonSize,
                                        titleSize: desktopSectionTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleUnderlineSize,
                                        spacerSize: desktopSpacerSize),
                                    for (var language in person[0]["languages"])
                                      Languages(
                                          label: language["language"],
                                          fluency: language["fluency"],
                                          progressionBarWidth:
                                              desktopProgressionBarWidth,
                                          labelFontSize: desktopLabelFontSize,
                                          progression: language["percentage"],
                                          spacerSize: desktopSpacerSize),
                                    SizedBox(
                                      height: desktopSpacerSize,
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Profile(
                                      titleSize: desktopSectionTitleSize,
                                      titleUnderlineSize: desktopSectionTitleUnderlineSize,
                                      profile: person[0]["profile"],
                                      labelFontSize: desktopLabelFontSize,
                                      spacerSize: desktopSpacerSize,
                                      widgetSpacerSize: desktopWidgetSpacerSize
                                    ),
                                    JobSectionTitle(
                                        iconButtonSize: desktopHeaderIconButtonSize,
                                        titleSize: desktopSectionTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleUnderlineSize,
                                        spacerSize: desktopSpacerSize),
                                    for (var job in person[0]["jobs"])
                                      Job(
                                          iconSize: desktopIconSize,
                                          title: job["title"],
                                          timeStart: DateTime.parse(job["time"]["start"].toDate().toString()),
                                          timeEnd: DateTime.parse(job["time"]["end"].toDate().toString()),
                                          description: job["description"],
                                          labelFontSize: desktopLabelFontSize,
                                          spacerSize: desktopSpacerSize),
                                    SizedBox(
                                      height: desktopSpacerSize,
                                    ),
                                    EducationSectionTitle(
                                        iconButtonSize: desktopHeaderIconButtonSize,
                                        titleSize: desktopSectionTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleUnderlineSize,
                                        spacerSize: desktopSpacerSize),
                                    for (var education in person[0]
                                        ["education"])
                                      Education(
                                          iconSize: desktopIconSize,
                                          academy: education["academy"],
                                          course: education["course"],
                                          timeStart: DateTime.parse(education["time"]["start"].toDate().toString()),
                                          timeEnd: DateTime.parse(education["time"]["end"].toDate().toString()),
                                          labelFontSize: desktopLabelFontSize,
                                          spacerSize: desktopSpacerSize),
                                    SizedBox(
                                      height: desktopSpacerSize,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 150.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
