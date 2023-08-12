import 'package:evika/utils/constants.dart';
import 'package:evika/utils/widgets/PopUpMenuBtn.dart';
import 'package:evika/utils/widgets/chat/show_default_chat_screen.dart';
import 'package:evika/utils/widgets/custom_user_chat.dart';
import 'package:evika/view_models/navigation.dart/navigation_viewmodel.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/views/chat_view/chart.dart';
import 'package:evika/views/chat_view/chart_view_home.dart';
import 'package:evika/views/chat_view/user_Chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class WebChatHomePage extends StatefulWidget {
  const WebChatHomePage({Key? key}) : super(key: key);

  @override
  State<WebChatHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebChatHomePage> {
  List<String> homePagePopUpMenu = [
    "New group",
    "New broadcast",
    "Linked device",
    "Starred messages",
    "Payment",
    "Setting",
  ];
  final ScrollController scrollController = ScrollController();

  int contrr = 1;
  int i = 0;
  final controller = ScrollController();
  UserChatHomeVM userChatHomeVM = Get.put(UserChatHomeVM());
  NavigationController nv = Get.isRegistered<NavigationController>()
      ? Get.find()
      : Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatHomeVM>(builder: (vm) {
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: Row(
            children: [
              SizedBox(
                // height: vm.chatUsersList.length * 80.0,
                width: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                      width: 400,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  vm.chatUsersList.isEmpty
                                      ? Container()
                                      : CircularAvatarWidget(
                                          userChatModel: vm.chatUsersList[0],
                                          radiusOfAvatar: 22,
                                          isChatPage: false,
                                          isContactPage: false,
                                        ),
                                  Row(children: [
                                    Stack(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.circle_outlined,
                                              size: 25,
                                              color: Colors.grey.shade600,
                                            )),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Icon(Icons.circle,
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.5),
                                              size: 10),
                                        ),
                                      ],
                                    ),
                                    AppBarActionBtn(
                                      iconName: Icons.message,
                                      color: Colors.grey[600],
                                      iconSize: 25,
                                    ),
                                    PopupMenuBtn(items: homePagePopUpMenu)
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            // color: Colors.white,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.white
                                    : AppColors.black,
                            height: 55,
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 350,
                                  // height: 40,
                                  // color: Colors.white,
                                  child: CupertinoSearchTextField(
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 40),
                                    backgroundColor:
                                        Color.fromARGB(255, 240, 242, 245),
                                    placeholder: "Search or start new text",
                                    placeholderStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Icon(Icons.bar_chart)
                              ],
                            ),
                          ),
                          Container(
                              height: 1, color: Colors.grey.withOpacity(0.3)),
                        ],
                      ),
                      // ),
                    ),
                    // ),
                    Expanded(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height - 350,
                          child: const Chats()),
                    ),
                  ],
                ),
              ),
              vm.chatUsersList.isEmpty &&
                      vm.selectedUserForChatWeb == null &&
                      vm.selectedUserForChatWeb?.receiverId == null
                  ? const ShowDefaultScreen(margin: 200)
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: constraints.maxWidth - 400,
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: UserChatPage(
                          receiverId:
                              vm.selectedUserForChatWeb?.receiverId ?? "",
                          i: vm.selectedUserForChatWeb?.i ?? 0,
                          receiverName: vm.selectedUserForChatWeb?.name ??
                              "showDefaultVikramNegi",
                          isWeb: true,
                        ),
                      ))
            ],
            //   ),
            // ),
          ),
        );
      });
    });
  }
}

class AppBarActionBtn extends StatelessWidget {
  final Widget? ontapAction;
  final IconData iconName;
  final double? iconSize;
  final Color? color;

  const AppBarActionBtn({
    Key? key,
    this.ontapAction,
    required this.iconName,
    this.iconSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          ontapAction!;
        },
        icon: Icon(
          iconName,
          size: iconSize ?? 24.0,
          color: color ?? Colors.white,
        ));
  }
}
