import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taxi_grad/core/extentions/app_context.dart';
import 'package:taxi_grad/core/extentions/md_extension_state.dart';
import 'package:taxi_grad/core/utils/app_colors.dart';
import 'package:taxi_grad/core/utils/app_texts.dart';
import 'package:taxi_grad/core/utils/globs.dart';
import 'package:taxi_grad/core/utils/kkey.dart';
import 'package:taxi_grad/core/utils/msg.dart';
import 'package:taxi_grad/core/utils/service_call.dart';
import 'package:taxi_grad/core/utils/svkey.dart';
import 'package:taxi_grad/core/widgets/image_picker_view.dart';
import 'package:taxi_grad/core/widgets/popup_layout.dart';
import 'package:taxi_grad/core/widgets/round_button.dart';
import 'package:taxi_grad/features/login/presentation/driver_edit_profile_view.dart';
import 'package:taxi_grad/features/menu/edit_profile_view.dart';

class ProfileImageView extends StatefulWidget {
  final bool showBack;
  const ProfileImageView({super.key, this.showBack = true});

  @override
  State<ProfileImageView> createState() => _ProfileImageViewState();
}

class _ProfileImageViewState extends State<ProfileImageView> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: widget.showBack
            ? IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Image.asset(
                  "assets/img/back.png",
                  width: 25,
                  height: 25,
                ),
              )
            : null,
        centerTitle: true,
        title: Text(
          "Profile Image",
          style: TextStyle(
              color: TColor.primaryText,
              fontSize: 25,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PopupLayout(
                      child: ImagePickerView(
                        didSelect: (imagePath) {
                          image = File(imagePath);
                          serviceCall({"image": image!});
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 10)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: image != null
                        ? Image.file(
                            image!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 100,
                            color: TColor.secondaryText,
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              RoundButton(
                onPressed: () {
                  if (ServiceCall.userType == 2) {
                    context.push(const DriverEditProfileView());
                  } else {
                    context.push(const EditProfileView());
                  }
                },
                title: "NEXT",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void serviceCall(Map<String, File> imagePara) {
    Globs.showHUD();
    ServiceCall.multipart({}, SVKey.svProfileImageUpload,
        isTokenApi: true, imgObj: imagePara, withSuccess: (responseObj) async {
      Globs.hideHUD();
      if ((responseObj[KKey.status] ?? "") == "1") {
        ServiceCall.userObj = responseObj[KKey.payload] as Map? ?? {};
        Globs.udSet(ServiceCall.userObj, AppTexts.userPayload);
        mdShowAlert("", responseObj[KKey.message] ?? MSG.success, () {});
      } else {
        mdShowAlert("Error", responseObj[KKey.message] ?? MSG.fail, () {});
      }
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert("Error", err, () {});
    });
  }
}
