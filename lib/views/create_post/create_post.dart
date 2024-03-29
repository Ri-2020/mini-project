import 'dart:io';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/constants.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/views/create_post/create_post_viewmodel.dart';
import 'package:evika/views/create_post/selected_image_crousel_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostPage extends StatelessWidget {
  CreatePostPage({super.key});
  final CreatePostVM vm = Get.put(CreatePostVM());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Get.width > Constants.webWidth
          ? AppBar(
              toolbarHeight: 0,
            )
          : AppBar(
              title: const Text(
                'Create Post',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontFamily: "LexendDeca",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.secondaryColor,
            ),
      body: GetBuilder<CreatePostVM>(builder: (vm) {
        return Center(
          child: SingleChildScrollView(
            child: Container(
              width: Get.width > Constants.webWidth ? Constants.mwidth : width,
              margin: const EdgeInsets.only(
                  bottom: 20, left: 20, right: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Details',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontFamily: "LexendDeca",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: Get.width > Constants.webWidth
                            ? Constants.mwidth
                            : width,
                        height: Get.width > Constants.webWidth
                            ? Constants.mwidth * (1080 / 1920)
                            : width * (1080 / 1920),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: vm.selectedImages.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(vm
                                      .selectedImages[vm.viewImageIndex].path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: InkWell(
                                  onTap: () {
                                    vm.pickImage();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        // color: AppColors.accentTextColor,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          // color: AppColors.accentColor,
                                        ),
                                      ),
                                      const Text("Select Image"),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      vm.selectedImages.isNotEmpty
                          ? Positioned(
                              top: 30,
                              right: 15,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(196, 46, 46, 46),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "${vm.viewImageIndex + 1}/${vm.selectedImages.length}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Positioned(
                        bottom: 20,
                        right: 15,
                        child: InkWell(
                          onTap: () {
                            if (vm.selectedImages.isNotEmpty) {
                              Get.to(
                                SelectedImageCrousel(
                                  selectedImages: vm.selectedImages,
                                  imageNumber: vm.viewImageIndex,
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(222, 57, 57, 57),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  vm.selectedImages.isNotEmpty
                      ? Container(
                          width: Get.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: vm.selectedImages.length == 4
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.start,
                            children: showImageRowList(),
                          ),
                        )
                      : const SizedBox(),
                  Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              maxLength: 30,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              // inputFormatters: [],
                              controller: vm.titleController,

                              decoration: const InputDecoration(
                                isDense: true,
                                labelText: 'Title',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              maxLength: 50,
                              controller: vm.descriptionController,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                labelText: 'Short Discription',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.transparent,
                              child: TextFormField(
                                maxLength: 1000,
                                controller: vm.eventDescriptionController,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: "Event Long Description",
                                  labelText: "Description",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: vm.locationController,
                              decoration: const InputDecoration(
                                labelText: 'Location',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.timer),
                                TextButton(
                                  onPressed: () {
                                    vm.pickDates(context);
                                  },
                                  child: const Text('Select Date'),
                                ),
                              ],
                            ),
                            vm.startAndEndDate.isNotEmpty
                                ? showPickedDates(
                                    context,
                                    vm.startAndEndDate[0],
                                    vm.startAndEndDate[1])
                                : const SizedBox(),
                            UtilWidgetsAndFunctions.gapy(20),
                            const Divider(),
                            InkWell(
                              onTap: () {
                                vm.isRegistrationRequired =
                                    !vm.isRegistrationRequired;

                                if (vm.isRegistrationRequired) {
                                  vm.attentionHeight = 50;
                                } else {
                                  vm.attentionHeight = 0;
                                }

                                vm.update();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.padded,
                                      splashRadius: 20,
                                      shape: const CircleBorder(),
                                      onChanged: (value) {
                                        vm.isRegistrationRequired =
                                            !vm.isRegistrationRequired;
                                        if (vm.isRegistrationRequired) {
                                          vm.attentionHeight = 100;
                                        } else {
                                          vm.attentionHeight = 0;
                                        }
                                        vm.update();
                                      },
                                      value: vm.isRegistrationRequired,
                                    ),
                                    const Text("Registration Required"),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 300),
                              width: Get.width,
                              padding: EdgeInsets.all(10),
                              constraints:
                                  BoxConstraints(maxHeight: vm.attentionHeight),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor,
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text(
                                "ATTENTION : You can see the registered users inside the post by clicking on the registrations  button ",
                                style: TextStyle(
                                  wordSpacing: -0.5,
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            UtilWidgetsAndFunctions.gapy(10),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text(
                                "On ckecking this box, you will be able to add registration process to your event each person who wants to register for your event will have to register first this will help in case of any arrangement required event according to the no. of people\n\nNote: Registration of user is not mandatory",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  wordSpacing: -0.5,
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            UtilWidgetsAndFunctions.gapy(20),
                            ElevatedButton(
                              onPressed: () async {
                                debugPrint("tapped");
                                vm.createPost();
                              },
                              child: const Text('Create Post'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget showSelector(
      {required String name, required bool value, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashRadius: 20,
              shape: const CircleBorder(),
              onChanged: (value) {
                onTap();
              },
              value: value,
            ),
            Text(name),
          ],
        ),
      ),
    );
  }

  List<Widget> showImageRowList() {
    List<Widget> res = [];
    for (var image in vm.selectedImages) {
      res.add(
        Stack(
          children: [
            InkWell(
              onTap: () {
                vm.viewImageIndex = vm.selectedImages.indexOf(image);
                vm.update();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    File(image.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 5,
              child: InkWell(
                onTap: () {
                  if (vm.viewImageIndex == vm.selectedImages.indexOf(image)) {
                    vm.viewImageIndex = 0;
                    vm.update();
                    vm.selectedImages.remove(image);
                    vm.update();
                  }
                  vm.selectedImages.remove(image);
                  vm.update();
                },
                child: const Icon(
                  CupertinoIcons.multiply_circle_fill,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    }

    if (vm.selectedImages.length < 4) {
      res.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 60,
          height: 60,
          child: Center(
            child: IconButton(
              onPressed: () {
                vm.pickImage();
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ),
      );
    }

    return res;
  }

  Widget showPickedDates(context, DateTime start, DateTime end) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: InkWell(
                onTap: () {
                  vm.pickDates(context);
                },
                child: Column(
                  children: [
                    const Text(
                      "Start Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          // color: HexColor('#707070'),
                          color: AppColors.greenColor,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 120,
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.primaryColor,
                                blurRadius: 5,
                                spreadRadius: -4,
                                offset: Offset(0, 0),
                              ),
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.09, 0.02],
                                colors: [AppColors.greenColor, Colors.white]),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  start.day.toString(),
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "${vm.monthList[start.month - 1]} ${start.year}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const Divider(),
                                Text(
                                  "${start.hour}:${start.minute}",
                                  style: const TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 120,
                child: Icon(
                  Icons.arrow_right_rounded,
                  size: 50,
                  color: AppColors.accentTextColor,
                ),
                // color: AppColors.accentColor,
              ),
            ),
            SizedBox(
              child: InkWell(
                onTap: () {
                  vm.pickDates(context);
                },
                child: Column(
                  children: [
                    const Text(
                      "End Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'LexendDeca',
                          // color: HexColor('#707070'),
                          color: AppColors.redColor,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Stack(children: [
                      Container(
                        width: 80,
                        height: 120,
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primaryColor,
                              blurRadius: 5,
                              spreadRadius: -4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.09, 0.02],
                              colors: [Colors.red, Colors.white]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                end.day.toString(),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "${vm.monthList[end.month - 1]} ${end.year}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              const Divider(),
                              Text(
                                "${end.hour}:${end.minute}",
                                style: const TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          // color: AppColors.white,
          width: Get.width,
          height: 50,
          child: const Center(),
        )
      ]),
    );
  }
}
