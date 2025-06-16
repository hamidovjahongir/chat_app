import 'package:chat_app/core/extensions/num_extensions.dart';
import 'package:chat_app/core/extensions/padding_extension.dart';
import 'package:chat_app/core/services/permission_service.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/chat/data/models/message.dart';
import 'package:chat_app/features/chat/view/widgets/chat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/chat_bloc.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();
  final PermissionService permissionWithService = PermissionService();
  File? file;

  Future<void> pickerImageFile() async {
    final picker = ImagePicker();
    final pickImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickImage == null) return;
    setState(() {
      file = File(pickImage.path);
    });
  }

  Future<void> pickerCameraFile() async {
    final picker = ImagePicker();
    final pickImage = await picker.pickImage(source: ImageSource.camera);
    if (pickImage == null) return;
    setState(() {
      file = File(pickImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ChatBody(),
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  pickerImageFile();
                  // permissionWithService.requestGalleryPermission();
                  // final isDone =
                  //     await permissionWithService.requestGalleryPermission();
                  // if (isDone) {
                  //   pickerImageFile();
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //         content: Text("Galleryaga ruxsat berilmadi")),
                  //   );
                  // }
                },
                icon: SvgPicture.asset(AppImages.add),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (textEditingController.text.isNotEmpty) {
                            context.read<ChatBloc>().add(
                                  ChatEvent.sendMessage(
                                    Message(
                                      name: "name",
                                      message:
                                          textEditingController.text.trim(),
                                      time: DateTime.now().toIso8601String(),
                                    ),
                                  ),
                                );
                          }
                          textEditingController.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ),
              ),
              10.width,
              Row(
                children: [
                  SvgPicture.asset(AppImages.camera2),
                  IconButton(
                    onPressed: () async {
                      final isDone =
                          await permissionWithService.requestCameraPermission();
                      if (isDone) {
                        pickerCameraFile();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Kamera ruxsat berilmadi")),
                        );
                      }
                    },
                    icon: SvgPicture.asset(AppImages.camera),
                  ),
                  SvgPicture.asset(AppImages.galos),
                ],
              ),
            ],
          ).paddingOnly(bottom: 20),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
