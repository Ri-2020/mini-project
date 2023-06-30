import 'package:evika/auth/signup.dart';
import 'package:evika/utils/constants.dart';
import 'package:evika/utils/user_functionality.dart';
import 'package:evika/utils/widgets/login_first_dialogbox.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiedBarCommentSection extends StatelessWidget {
  const SiedBarCommentSection({
    super.key,
    required this.height,
    required this.vm,
    required this.commonVM,
    required this.width,
  });

  final double height;
  final double width;
  final PostVM vm;
  final CommonVM commonVM;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.commentSectionWidth,
      child: commonVM.isLoading
          ? ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height,
                minWidth: width < Constants.webWidth
                    ? width
                    : Constants.commentSectionWidth,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CommentContent(
              width: width, vm: vm, commonVM: commonVM, height: height),
    );
  }
}

class CommentContent extends StatelessWidget {
  const CommentContent({
    super.key,
    required this.width,
    required this.vm,
    required this.commonVM,
    required this.height,
  });

  final double width;
  final PostVM vm;
  final CommonVM commonVM;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextFormFieldContainer(
              width: Get.width < Constants.webWidth
                  ? width - 20
                  : Constants.commentSectionWidth - 20,
              icon: Icons.add_reaction,
              hintText: "Add Comment",
              function: () {},
              controller: vm.commentController,
              isMobileNumber: false,
              suffix: InkWell(
                onTap: () async {
                  if (!await UserFunctions.isUserLoggedInFun()) {
                    loginFirstDialog(context);
                    return;
                  }
                  commonVM.addComment(
                      vm.postList[vm.selectedPostForComment].id!,
                      vm.commentController.text.trim());
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              )),
        ),
        Container(
            height: height - 200,
            width: Constants.commentSectionWidth,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: !commonVM.isLoading
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: commonVM.commentList.isEmpty
                        ? 1
                        : commonVM.commentList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return commonVM.commentList.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(commonVM
                                          .commentList[index].userImage),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onLongPress: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: const Text(
                                                    "Do you want to delete this comment?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("No")),
                                                  TextButton(
                                                      onPressed: () {
                                                        commonVM
                                                            .commentFuntionality(
                                                                commonVM
                                                                    .commentList[
                                                                        index]
                                                                    .postId,
                                                                "delete",
                                                                commonVM
                                                                    .commentList[
                                                                        index]
                                                                    .id);
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("Yes")),
                                                ],
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                          width: width < Constants.webWidth
                                              ? width - 80
                                              : Constants.commentSectionWidth -
                                                  80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                commonVM.commentList[index]
                                                    .username,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                text: commonVM
                                                    .commentList[index].text,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                              Row(
                                                children: [
                                                  TextButton.icon(
                                                      label: Text(
                                                          "${commonVM.commentList[index].likes}"),
                                                      onPressed: () {
                                                        commonVM
                                                            .commentFuntionality(
                                                                commonVM
                                                                    .commentList[
                                                                        index]
                                                                    .postId,
                                                                "likes",
                                                                commonVM
                                                                    .commentList[
                                                                        index]
                                                                    .id);
                                                      },
                                                      icon: Icon(
                                                        Icons.thumb_up,
                                                        color: Colors
                                                            .grey.shade600,
                                                        size: 20,
                                                      )),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child:
                                                          const Text("Reply")),
                                                ],
                                              ),
                                              index ==
                                                      commonVM.commentList
                                                              .length -
                                                          1
                                                  ? const SizedBox(
                                                      height: 40,
                                                    )
                                                  : const SizedBox()
                                            ],
                                          )),
                                    )
                                  ]),
                            )
                          : const Text(
                              "No Comments",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )),
      ],
    );
  }
}

class WebComment extends StatelessWidget {
  const WebComment({
    super.key,
    required this.height,
    required this.vm,
    required this.commonVM,
    required this.width,
  });

  final double height;
  final double width;
  final PostVM vm;
  final CommonVM commonVM;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            vm.postList[vm.selectedPostForComment].image![0],
            height: 50,
            width: 50,
          ),
          CommentContent(
              width: width, vm: vm, commonVM: commonVM, height: height),
        ],
      ),
    );
  }
}

Future<dynamic> bottomModelWebCommentWidget(
    BuildContext context, PostVM vm, int i, double width, double height) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return GetBuilder<CommonVM>(builder: (commonVM) {
          return DraggableScrollableSheet(
            maxChildSize: 1,
            initialChildSize: 1,
            minChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.close, size: 50),
                        ),
                      ),
                      Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                vm.postList[i].image![0],
                                height: height * 0.9,
                                width: width * 0.45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: TextFormFieldContainer(
                                    width: width * 0.4,
                                    icon: Icons.add_reaction,
                                    hintText: "Add Comment",
                                    function: () {},
                                    controller: vm.commentController,
                                    isMobileNumber: false,
                                    suffix: InkWell(
                                      onTap: () async {
                                        if (!await UserFunctions
                                            .isUserLoggedInFun()) {
                                          loginFirstDialog(context);
                                          return;
                                        }
                                        commonVM.addComment(vm.postList[i].id!,
                                            vm.commentController.text.trim());
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                commonVM.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        height: height - 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: !commonVM.isLoading
                                            ? ListView.builder(
                                                controller: scrollController,
                                                itemCount:
                                                    commonVM.commentList.isEmpty
                                                        ? 1
                                                        : commonVM
                                                            .commentList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return commonVM.commentList
                                                          .isNotEmpty
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 25,
                                                                  backgroundImage: NetworkImage(commonVM
                                                                      .commentList[
                                                                          index]
                                                                      .userImage),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                GestureDetector(
                                                                  onLongPress:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return AlertDialog(
                                                                            content:
                                                                                const Text("Do you want to delete this comment?"),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text("No")),
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    commonVM.commentFuntionality(commonVM.commentList[index].postId, "delete", commonVM.commentList[index].id);
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text("Yes")),
                                                                            ],
                                                                          );
                                                                        });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                          width: width * 0.4 -
                                                                              110,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                commonVM.commentList[index].username,
                                                                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                                                              ),
                                                                              RichText(
                                                                                  text: TextSpan(
                                                                                text: commonVM.commentList[index].text,
                                                                                style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                                                              )),
                                                                              Row(
                                                                                children: [
                                                                                  TextButton.icon(
                                                                                      label: Text("${commonVM.commentList[index].likes}"),
                                                                                      onPressed: () {
                                                                                        commonVM.commentFuntionality(commonVM.commentList[index].postId, "likes", commonVM.commentList[index].id);
                                                                                      },
                                                                                      icon: Icon(
                                                                                        Icons.thumb_up,
                                                                                        color: Colors.grey.shade600,
                                                                                        size: 20,
                                                                                      )),
                                                                                  TextButton(onPressed: () {}, child: const Text("Reply")),
                                                                                ],
                                                                              ),
                                                                              i == commonVM.commentList.length - 1
                                                                                  ? const SizedBox(
                                                                                      height: 40,
                                                                                    )
                                                                                  : const SizedBox()
                                                                            ],
                                                                          )),
                                                                )
                                                              ]),
                                                        )
                                                      : const Text(
                                                          "No Comments",
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        );
                                                },
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // CommentSectionWidget(
              //     width: width,
              //     commonVM: commonVM,
              //     height: height,
              //     i: i,
              //     scrollController: scrollController,
              //     vm: vm);
            },
            // ),
          );
        });
      });
}
