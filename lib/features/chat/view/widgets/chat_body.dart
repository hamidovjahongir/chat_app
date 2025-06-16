
import 'package:chat_app/core/extensions/num_extensions.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/chat/view/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc.dart';
import 'package:intl/intl.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const MyAppBar(),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  AppImages.backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                ),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      success: (chat) {
                        return ListView.separated(
                          reverse: true,
                          padding: const EdgeInsets.only(bottom: 10),
                          itemCount: chat.length,
                          separatorBuilder: (context, index) => 4.height,
                          itemBuilder: (context, index) {
                            final data = chat[index];
                            final isMe = data.name == "name";

                            return Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (!isMe) 12.width,
                                if (!isMe) const CircleAvatar(radius: 16),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 300),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isMe
                                        ? const Color(0xFFDCF7C5)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 48),
                                        child: Text(
                                          data.message,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Text(
                                          DateFormat.Hm().format(
                                            DateTime.parse(data.time),
                                          ),
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      failure: (failure) =>
                          Center(child: Text(failure.toString())),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
