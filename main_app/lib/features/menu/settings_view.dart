import 'package:flutter/material.dart';
import 'package:taxi_grad/core/extentions/app_context.dart';
import 'package:taxi_grad/core/utils/app_colors.dart';
import 'package:taxi_grad/core/widgets/setting_row.dart';
import 'package:taxi_grad/features/home/support/support_list_view.dart';
import 'package:taxi_grad/features/login/presentation/bank_detail_view.dart';
import 'package:taxi_grad/features/login/presentation/document_upload_view.dart';
import 'package:taxi_grad/features/menu/change_password_view.dart';
import 'package:taxi_grad/features/menu/contact_us_view.dart';
import 'package:taxi_grad/features/menu/my_profile_view.dart';
import 'package:taxi_grad/features/menu/my_vehicle_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 25,
            height: 25,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
            color: TColor.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      backgroundColor: TColor.lightWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            SettingRow(
                title: "My Profile",
                icon: "assets/img/sm_profile.png",
                onPressed: () {
                  context.push(const MyProfileView());
                }),
            SettingRow(
                title: "My Vehicle",
                icon: "assets/img/sm_my_vehicle.png",
                onPressed: () {
                  context.push(const MyVehicleView());
                }),
            SettingRow(
                title: "Personal Documents",
                icon: "assets/img/sm_document.png",
                onPressed: () {
                  context.push(
                      const DocumentUploadView(title: "Personal Document"));
                }),
            SettingRow(
                title: "Bank details",
                icon: "assets/img/sm_bank.png",
                onPressed: () {
                  context.push(const BankDetailView());
                }),
            SettingRow(
                title: "Change Password",
                icon: "assets/img/sm_password.png",
                onPressed: () {
                  context.push(const ChangePasswordView());
                }),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "HELP",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SettingRow(
                title: "Terms & Conditions",
                icon: "assets/img/sm_document.png",
                onPressed: () {}),
            SettingRow(
                title: "Privacy Policies",
                icon: "assets/img/sm_document.png",
                onPressed: () {}),
            SettingRow(
                title: "About",
                icon: "assets/img/sm_document.png",
                onPressed: () {}),
            SettingRow(
                title: "Contact us",
                icon: "assets/img/sm_profile.png",
                onPressed: () {
                  context.push(const ContactUsView());
                }),
            SettingRow(
                title: "Supports",
                icon: "assets/img/sm_profile.png",
                onPressed: () {
                  context.push(const SupportListView());
                }),
          ],
        ),
      ),
    );
  }
}
