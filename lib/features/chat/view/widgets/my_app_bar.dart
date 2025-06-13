import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    Icon(Icons.arrow_back_ios, color: AppColors.headIconColor)),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.amber,
                child: Image.asset(AppImages.person1),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nt n15",
                  style: GoogleFonts.abel(fontWeight: FontWeight.bold),
                ),
                Text("18 ta azo"),
              ],
            ),
          ],
        ),
        Row(
          spacing: 20,
          children: [
            SvgPicture.asset(AppImages.videoCall),
            SvgPicture.asset(AppImages.phone),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ],
    );
  }
}
