import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/widgets/background.dart';
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
                    child: CircularProgressIndicator(color: Colors.white70)));
          } else {
            List<dynamic>? person =
                snapshot.data?.docs.map((document) => document.data()).toList();
            return Background(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(150.0, 50.0, 150.0, 50.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(
                            image: person![0]["image"],
                            imageSize: desktopHeaderImageSize,
                            name: person[0]["name"],
                            nameSize: desktopHeaderNameSize,
                            jobTitle: person[0]["jobTitle"].toUpperCase(),
                            jobTitleSize: desktopHeaderJobTitleSize,
                            jobTitleSpacing: desktopHeaderJobTitleSpacing,
                            iconButtonSize: desktopHeaderIconButtonSize,
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
                                    SectionTitle(
                                        title: "PERSONAL INFORMATION",
                                        titleSize: desktopSectionTitleTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleTitleUnderlineSize,
                                        spacerSize:
                                            desktopSectionTitleSpacerSize),
                                    PersonalInfoNationality(
                                        iconSize: desktopIconSize,
                                        label: person[0]["nationality"],
                                        labelFontSize: desktopLabelFontSize),
                                    PersonalInfoEmail(
                                        iconSize: desktopIconSize,
                                        email: person[0]["email"],
                                        labelFontSize: desktopLabelFontSize),
                                    PersonalInfoLinkedIn(
                                        iconSize: desktopIconSize,
                                        url: person[0]["linkedIn"]["url"],
                                        label: person[0]["linkedIn"]["label"],
                                        labelFontSize: desktopLabelFontSize),
                                    PersonalInfoPhoneNumber(
                                        iconSize: desktopIconSize,
                                        phoneNumber: person[0]["phoneNumber"],
                                        labelFontSize: desktopLabelFontSize),
                                    PersonalInfoLocation(
                                        iconSize: desktopIconSize,
                                        label: person[0]["location"],
                                        labelFontSize: desktopLabelFontSize),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    SectionTitle(
                                        title: "SKILLS",
                                        titleSize: desktopSectionTitleTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleTitleUnderlineSize,
                                        spacerSize:
                                            desktopSectionTitleSpacerSize),
                                    for (var skill in person[0]["skills"])
                                      ProgressionBar(
                                          label: skill["skill"],
                                          labelFontSize: desktopLabelFontSize,
                                          progression: skill["percentage"]),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    SectionTitle(
                                        title: "LANGUAGES",
                                        titleSize: desktopSectionTitleTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleTitleUnderlineSize,
                                        spacerSize:
                                            desktopSectionTitleSpacerSize),
                                    for (var language in person[0]["languages"])
                                      ProgressionBar(
                                          label:
                                              "${language["language"]} (${language["fluency"]})",
                                          labelFontSize: desktopLabelFontSize,
                                          progression: language["percentage"]),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: VerticalDivider(
                                  thickness: 2,
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
                                        titleSize: desktopSectionTitleTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleTitleUnderlineSize,
                                        spacerSize:
                                            desktopSectionTitleSpacerSize),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    SectionTitle(
                                        title: "PROFESSIONAL EXPERIENCE",
                                        titleSize: desktopSectionTitleTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleTitleUnderlineSize,
                                        spacerSize:
                                            desktopSectionTitleSpacerSize),
                                    for (var job in person[0]["jobs"])
                                      Job(
                                          iconSize: desktopIconSize,
                                          title: job["title"],
                                          time: "(${job["time"]["start"]} - ${job["time"]["end"]})",
                                          description: job["description"],
                                          labelFontSize: desktopLabelFontSize,
                                          spacerSize: desktopSpacerSize),
                                    const SizedBox(
                                      height: 40.0,
                                    ),
                                    SectionTitle(
                                        title: "EDUCATION",
                                        titleSize: desktopSectionTitleTitleSize,
                                        titleUnderlineSize:
                                            desktopSectionTitleTitleUnderlineSize,
                                        spacerSize:
                                            desktopSectionTitleSpacerSize),
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
