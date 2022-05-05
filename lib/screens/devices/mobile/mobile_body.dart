import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                              name: person[0]["name"],
                              nameSize: mobileHeaderNameSize,
                              jobTitle: person[0]["jobTitle"].toUpperCase(),
                              jobTitleSize: mobileHeaderJobTitleSize,
                              jobTitleSpacing: mobileHeaderJobTitleSpacing,
                              iconButtonSize: mobileHeaderIconButtonSize,
                              iconButtonSpacerSize: mobileHeaderIconButtonSpacerSize,
                              spacerSize: mobileSpacerSize),
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
                              spacerSize: mobileSpacerSize,
                              widgetSpacerSize: mobileWidgetSpacerSize),
                          Profile(
                            titleSize: mobileSectionTitleSize,
                            titleUnderlineSize: mobileSectionTitleUnderlineSize,
                            profile: person[0]["profile"],
                            labelFontSize: mobileLabelFontSize,
                            spacerSize: mobileSpacerSize,
                            widgetSpacerSize: mobileWidgetSpacerSize
                          ),
                          SkillsSectionTitle(
                              iconButtonSize: mobileHeaderIconButtonSize,
                              titleSize: mobileSectionTitleSize,
                              titleUnderlineSize:
                              mobileSectionTitleUnderlineSize,
                              spacerSize: mobileSpacerSize),
                          for (var skill in person[0]["skills"])
                            Skills(
                                label: skill["skill"],
                                progressionBarWidth: mobileProgressionBarWidth,
                                labelFontSize: mobileLabelFontSize,
                                progression: skill["percentage"],
                                spacerSize: mobileSpacerSize),
                          const SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                          ),
                          SizedBox(
                            height: mobileWidgetSpacerSize,
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
                                timeStart: DateTime.parse(job["time"]["start"].toDate().toString()),
                                timeEnd: DateTime.parse(job["time"]["end"].toDate().toString()),
                                description: job["description"],
                                labelFontSize: mobileLabelFontSize,
                                spacerSize: mobileSpacerSize),
                          SizedBox(
                            height: mobileSpacerSize,
                          ),
                          EducationSectionTitle(
                              iconButtonSize: mobileHeaderIconButtonSize,
                              titleSize: mobileSectionTitleSize,
                              titleUnderlineSize:
                              mobileSectionTitleUnderlineSize,
                              spacerSize: mobileSpacerSize),
                          for (var education in person[0]["education"])
                            Education(
                                iconSize: mobileIconSize,
                                academy: education["academy"],
                                course: education["course"],
                                timeStart: DateTime.parse(education["time"]["start"].toDate().toString()),
                                timeEnd: DateTime.parse(education["time"]["end"].toDate().toString()),
                                labelFontSize: mobileLabelFontSize,
                                spacerSize: mobileSpacerSize),
                          SizedBox(
                            height: mobileSpacerSize,
                          ),
                          LanguagesSectionTitle(
                              iconButtonSize: mobileHeaderIconButtonSize,
                              titleSize: mobileSectionTitleSize,
                              titleUnderlineSize:
                                  mobileSectionTitleUnderlineSize,
                              spacerSize: mobileSpacerSize),
                          for (var language in person[0]["languages"])
                            Languages(
                                label: language["language"],
                                fluency: language["fluency"],
                                progressionBarWidth: mobileProgressionBarWidth,
                                labelFontSize: mobileLabelFontSize,
                                progression: language["percentage"],
                                spacerSize: mobileSpacerSize),
                          const SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
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
