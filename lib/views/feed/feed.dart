import 'package:evika/appTheme.dart';
import 'package:evika/auth/signup.dart';
import 'package:evika/main.dart';
import 'package:evika/utils/constants.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/user_functionality.dart';
import 'package:evika/utils/widgets/login_first_dialogbox.dart';
import 'package:evika/utils/widgets/sidebar_comment_section.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/navigation.dart/navigation_viewmodel.dart';
import 'package:evika/views/chat_view/chart_view_home.dart';
import 'package:evika/views/chat_view/web_chat_home.dart';
import 'package:evika/views/home.dart';
import 'package:evika/views/settings/setting_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/colors.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<PostVM>(
      builder: (vm) {
        return GetBuilder<CommonVM>(
          builder: (commonVM) {
            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    width > Constants.webWidth
                        ? const SliverAppBar(
                            toolbarHeight: 0,
                          )
                        : SliverAppBar(
                            // toolbarHeight:
                            // Get.width > Constants.webWidth ? 200 : 0,
                            pinned: true,
                            floating: true,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            title: const Text(
                              "Feeds",
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              IconButton(
                                onPressed: () async {
                                  if (!await UserFunctions
                                      .isUserLoggedInFun()) {
                                    loginFirstDialog(context);
                                    return;
                                  }
                                  Get.to(
                                    const ChatHomeView(),
                                  );
                                },
                                icon: Icon(
                                  CupertinoIcons.chat_bubble_2_fill,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                            bottom: PreferredSize(
                              preferredSize: Size(Get.width, 40),
                              child: Suggessions(
                                width: width,
                              ),
                            ),
                          ),
                  ];
                },
                body: RefreshIndicator(
                  onRefresh: () async {
                    await vm.getAllPost();
                  },
                  child: !vm.isErrorOnFetchingData.value
                      ? SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              width < Constants.webWidth
                                  ? const SizedBox()
                                  : Row(
                                      children: [
                                        const WebSideBarWidget(),
                                        Divider(
                                          color: Colors.grey.shade800,
                                          thickness: 5,
                                        )
                                      ],
                                    ),
                              SizedBox(
                                width: Get.width < Constants.webWidth
                                    ? width
                                    : vm.showWebCommentSection
                                        ? width -
                                            Constants.commentSectionWidth -
                                            Constants.sizeBarWidth
                                        : width - Constants.sizeBarWidth,
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: width > Constants.webWidth
                                            ? 5
                                            : 20),
                                    width: Get.width < Constants.mwidth
                                        ? width
                                        : 560,
                                    child: Center(
                                      child: HomePage(),
                                    ),
                                  ),
                                ),
                              ),
                              (!vm.showWebCommentSection || width < 1280)
                                  ? const SizedBox()
                                  : LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        final screenWidth =
                                            constraints.maxWidth;
                                        if (screenWidth < 1280) {
                                          vm.showWebCommentSection = false;
                                          vm.update();
                                        }
                                        return SiedBarCommentSection(
                                          height: height,
                                          width: width,
                                          vm: vm,
                                          commonVM: commonVM,
                                        );
                                      },
                                    )
                            ],
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                const Text(
                                  "No data found",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey[800],
                                    ),
                                    foregroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    vm.getAllPost();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      "Try again",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class WebSideBarWidget extends StatelessWidget {
  const WebSideBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavigationController nv = Get.find<NavigationController>();
    return Container(
      width: Constants.sizeBarWidth,
      decoration: BoxDecoration(
          // color: Colors.grey.shade900,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.white
              : AppColors.black),
      child: Column(children: [
        const SizedBox(height: 20),
        Text("Evika",
            style: TextStyle(
                color: HexColor('#224957').withOpacity(0.7),
                fontFamily: 'LexendDeca',
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        InkWell(
          onTap: () {
            nv.changeIndex(0);
            debugPrint("Called side navigation");
          },
          child: WebSideBar(title: 'Home', icon: Icons.home),
        ),
        InkWell(
          onTap: () {
            nv.changeIndex(1);
            debugPrint("Called side navigation");
          },
          child: WebSideBar(title: 'Trending', icon: Icons.trending_up),
        ),
        InkWell(
          onTap: () {
            if (!nv.isUserLoggedIn) {
              loginFirstDialog(context);
              return;
            }
            nv.changeIndex(3);
            debugPrint("Called side navigation");
          },
          child: WebSideBar(title: 'Profile', icon: Icons.person),
        ),
        InkWell(
          onTap: () {
            if (!nv.isUserLoggedIn) {
              loginFirstDialog(context);
              return;
            }
            if (MediaQuery.of(context).size.width > Constants.webWidth) {
              // nv.changeIndex(4);
              Get.to(() => const WebChatHomePage());
              return;
            } else {
              // nv.changeIndex(0);
              Get.to(() => const ChatHomeView());
              debugPrint("Called side navigation");
            }
          },
          child: WebSideBar(
              title: 'Chat', icon: CupertinoIcons.chat_bubble_2_fill),
        ),
        InkWell(
            onTap: () {
              nv.changeIndex(2);
            },
            child: WebSideBar(
                title: 'Create', icon: CupertinoIcons.add_circled_solid)),
        InkWell(
            onTap: () {
              Get.to(() => SettingScreen());
            },
            child: WebSideBar(title: 'Settings', icon: Icons.settings)),
        const Spacer(),
        InkWell(
          onTap: () {
            if (Theme.of(context).brightness == Brightness.light) {
              Get.changeTheme(darkThemeData(context));
            } else {
              Get.changeTheme(lightThemeData(context));
            }
          },
          child: Icon(
            Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}

class WebSideBar extends StatelessWidget {
  WebSideBar({
    super.key,
    required this.title,
    required this.icon,
  });
  String title;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            hoverColor: Colors.grey.shade600,
            leading: InkWell(
              onTap: () {},
              child: Icon(
                icon,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
