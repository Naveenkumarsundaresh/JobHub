import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/profile_provider.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/auth/profile_update.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: "Profile",
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: const DrawerWidget(),
            ),
          ),
        ),
        body: Consumer<ProfileNotifier>(
          builder: (context, profileNitifier, child) {
            profileNitifier.getProfile();
            return FutureBuilder<ProfileRes>(
                future: profileNitifier.profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final UserData = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            width: width,
                            height: hieght * 0.12,
                            color: Color(kLight.value),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: CachedNetworkImage(
                                        imageUrl: "https://d326fntlu7tb1e.cloudfront.net/uploads/4821d814-ac87-4b22-aa80-ac7336916c9a-403017_avatar_default_head_person_unknown_icon.png", // Replace with your image URL
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    const WidthSpacer(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                            text: UserData!.username,
                                            style: appstyle(
                                                20,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                        Row(
                                          children: [
                                            Icon(
                                              MaterialIcons.location_pin,
                                              color: Color(kDarkGrey.value),
                                            ),
                                            const WidthSpacer(width: 5),
                                            ReusableText(
                                                text: UserData.location,
                                                style: appstyle(
                                                    16,
                                                    Color(kDarkGrey.value),
                                                    FontWeight.w600)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    profile = UserData.skills;
                                    Get.to(() => ProfileUpdate());
                                  },
                                  child: const Icon(
                                    Feather.edit,
                                    size: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Stack(
                            children: [
                              Container(
                                width: width,
                                height: hieght * 0.12,
                                color: Color(kLightGrey.value),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 12.w),
                                      width: 60.w,
                                      height: 70.h,
                                      color: Color(kLight.value),
                                      child: const Icon(
                                          FontAwesome5Regular.file_pdf,
                                          color: Colors.red,
                                          size: 40),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReusableText(
                                            text: "Resume from JobHub",
                                            style: appstyle(
                                                18,
                                                Color(kDark.value),
                                                FontWeight.w500)),
                                        ReusableText(
                                            text: "JobHub Resume",
                                            style: appstyle(
                                                16,
                                                Color(kDarkGrey.value),
                                                FontWeight.w500)),
                                      ],
                                    ),
                                    const WidthSpacer(width: 1)
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 2.h,
                                  right: 5.w,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: ReusableText(
                                        text: "Edit",
                                        style: appstyle(
                                            16,
                                            Color(kOrange.value),
                                            FontWeight.w500)),
                                  ))
                            ],
                          ),
                          const HeightSpacer(size: 20),
                          Container(
                            padding: EdgeInsets.only(left: 8.w),
                            width: width,
                            height: hieght * 0.06,
                            color: Color(kLightGrey.value),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ReusableText(
                                  text: UserData.email,
                                  style: appstyle(
                                      16, Color(kDark.value), FontWeight.w600)),
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Container(
                            padding: EdgeInsets.only(left: 8.w),
                            width: width,
                            height: hieght * 0.06,
                            color: Color(kLightGrey.value),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/usa.svg",
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  const WidthSpacer(width: 15),
                                  ReusableText(
                                      text: UserData.phone,
                                      style: appstyle(16, Color(kDark.value),
                                          FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Container(
                            color: Color(kLightGrey.value),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: ReusableText(
                                      text: "Skills",
                                      style: appstyle(16, Color(kDark.value),
                                          FontWeight.w600)),
                                ),
                                const HeightSpacer(size: 3),
                                SizedBox(
                                  height: hieght * 0.5,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: ListView.builder(
                                          itemCount: UserData.skills.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final skill =
                                                UserData.skills[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w),
                                                  width: width,
                                                  height: hieght * 0.06,
                                                  color: Color(kLight.value),
                                                  child: Row(
                                                    children: [
                                                      ReusableText(
                                                          text: skill,
                                                          style: appstyle(
                                                              16,
                                                              Color(
                                                                  kDark.value),
                                                              FontWeight
                                                                  .normal)),
                                                    ],
                                                  )),
                                            );
                                          })),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                });
          },
        ));
  }
}
