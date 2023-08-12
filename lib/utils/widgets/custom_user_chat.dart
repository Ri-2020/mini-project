import 'package:evika/models/chat/chat_page_model.dart';
import 'package:evika/models/user/user_chat_model.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/view_models/user_chat_viewmodal.dart';
import 'package:evika/views/chat_view/user_Chat_page.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class CustomUserCard extends StatelessWidget {
  CustomUserCard({
    Key? key,
    required this.isContactPage,
    required this.userChatModel,
    required this.iconSize,
    required this.isChatPage,
    required this.fontW,
  }) : super(key: key);

  final bool isContactPage;
  final ChatUsers userChatModel;
  final double? iconSize;
  final bool isChatPage;
  final FontWeight? fontW;

  UserChatHomeVM vm = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatHomeVM>(builder: (vm) {
      return Column(
        children: [
          ListTile(
            minVerticalPadding: isContactPage ? 15 : 4,
            leading: CircularAvatarWidget(
              userChatModel: userChatModel,
              radiusOfAvatar: iconSize ?? 25,
              isChatPage: isChatPage,
              isContactPage: isContactPage,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userChatModel.name,
                  style: TextStyle(
                    fontWeight: isContactPage ? fontW : FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                isChatPage
                    ? Text(
                        userChatModel.lastMessageTime != null
                            ? vm.convertDateTime(userChatModel.lastMessageTime)
                            : "05:45 PM",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      )
                    : Container(),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  // userChatModel.isgroup
                  //     ? Text(
                  //         "${userModel.name}: ",
                  //         style: const TextStyle(
                  //           fontSize: 16.0,
                  //         ),
                  //       )
                  //     :
                  isChatPage
                      ? const Icon(
                          Icons.done_all_rounded,
                          size: 17,
                        )
                      : Container(),
                  const SizedBox(
                    width: 5,
                  ),
                  isChatPage
                      ? Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          userChatModel.lastMessage.isNotEmpty
                              ? userChatModel.lastMessage
                              : "Hello",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        )
                      : Container(),
                  // isContactPage
                  // ?
                  // userChatModel.status != null
                  //     ? SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.70,
                  //         child: Text(
                  //           userModel.status!,
                  //           maxLines: 1,
                  //         ))
                  //     : Container()
                  // : Container(),
                ],
              ),
            ),
          )
        ],
      );
    });
    // Column(
    //   children: [
    //     ListTile(
    //       minVerticalPadding: isContactPage ? 15 : 4,
    //       leading: CircularAvatarWidget(
    //         userChatModel: userChatModel,
    //         radiusOfAvatar: iconSize ?? 25,
    //         isChatPage: isChatPage,
    //         isContactPage: isContactPage,
    //       ),
    //       title: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             userChatModel.name,
    //             style: TextStyle(
    //               fontWeight: (isContactPage) ? fontW : FontWeight.w600,
    //               fontSize: 17,
    //             ),
    //           ),
    //           isChatPage
    //               ? Text(
    //                   userChatModel.name,
    //                   style: const TextStyle(
    //                     color: Colors.grey,
    //                     fontSize: 14.0,
    //                   ),
    //                 )
    //               : Container(),
    //         ],
    //       ),
    //       subtitle: Container(
    //         padding: const EdgeInsets.only(top: 5),
    //         child: Row(
    //           children: [
    //             Text(
    //               "${userChatModel.name}: ",
    //               style: const TextStyle(
    //                 fontSize: 16.0,
    //               ),
    //             ),
    //             // : isChatPage
    //             //     ? const Icon(
    //             //         Icons.done_all_rounded,
    //             //         size: 17,
    //             //       )
    //             //     : Container(),
    //             isChatPage
    //                 ? Text(
    //                     userChatModel.lastMessage,
    //                     style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontSize: 14.0,
    //                     ),
    //                   )
    //                 : Container(),
    //             // isContactPage
    //             // ?SizedBox(
    //             //             width: MediaQuery.of(context).size.width * 0.70,
    //             //             child: Text(
    //             //               userChatModel.status!,
    //             //               maxLines: 1,
    //             //             ))
    //             //         : Container(),
    //           ],
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}

class CircularAvatarWidget extends StatelessWidget {
  const CircularAvatarWidget({
    Key? key,
    required this.userChatModel,
    required this.radiusOfAvatar,
    required this.isChatPage,
    required this.isContactPage,
  }) : super(key: key);
  final double radiusOfAvatar;
  final bool isChatPage;
  final bool isContactPage;

  final ChatUsers userChatModel;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radiusOfAvatar,
      foregroundColor: Theme.of(context).primaryColor,
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.hardEdge,
        child: userChatModel.profilePic.isNotEmpty
            ? Image.network(userChatModel.profilePic)
            : Image.asset("assets/svgs/person.svg"),
        // Icon(
        //   userChatModel.isgroup ? Icons.group_rounded : Icons.person,
        //   color: Colors.white,
        //   size: 40,
        // ),
      ),
    );
  }
}
