import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/chat_messages_provider.dart';
import '../providers/chat_methods_provider.dart';
import '../utils/chat_attachment_bottomsheet.dart';

class ChatMessagesScreen extends StatefulHookConsumerWidget {
  const ChatMessagesScreen({
    super.key,
    required this.room,
  });
  static const String routename = "chat_messages_screen";
  final types.Room room;

  @override
  ConsumerState<ChatMessagesScreen> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatMessagesScreen> {
  late ValueNotifier<bool> _isAttachmentUploading;
  late SupabaseChatController _chatController;
  late ChatMethods _chatMethods;

  @override
  void initState() {
    _chatController = SupabaseChatController(room: widget.room);
    _chatMethods = ref.read(chatMethodsProvider(_chatController, widget.room));
    super.initState();
  }

  void _handleImageSelection() async {
    final results = await _chatMethods.pickImage();

    try {
      _isAttachmentUploading.value = true;
      await _chatMethods.handlePickedImage(results);
      _isAttachmentUploading.value = false;
    } on PostgrestException catch (e) {
      if (mounted) {
        _isAttachmentUploading.value = false;
        context.showSnackBar(e.toString(), isError: true);
      }
    } catch (e) {
      if (mounted) {
        _isAttachmentUploading.value = true;
        context.showSnackBar(e.toString(), isError: true);
      }
    }
  }

  void _handleFileSelection() async {
    final results = await _chatMethods.pickFile();

    try {
      _isAttachmentUploading.value = true;
      await _chatMethods.handlePickedFile(results);
      _isAttachmentUploading.value = false;
    } on PostgrestException catch (e) {
      if (mounted) {
        _isAttachmentUploading.value = false;
        context.showSnackBar(e.toString(), isError: true);
      }
    } catch (e) {
      if (mounted) {
        _isAttachmentUploading.value = true;
        context.showSnackBar(e.toString(), isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _isAttachmentUploading = useState(false);
    final chatMessages = ref.watch(chatMessagesProvider(_chatController));

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: const Text('Chat'),
        ),
        body: switch (chatMessages) {
          AsyncData(:final value) => Chat(
              showUserNames: true,
              showUserAvatars: true,
              isAttachmentUploading: _isAttachmentUploading.value,
              messages: value,
              onAttachmentPressed: () => showChatAttachmentBottomSheet(
                context,
                onImagePick: _handleImageSelection,
                onFilePick: _handleFileSelection,
              ),
              onMessageTap: _chatMethods.messageTap,
              onPreviewDataFetched: _chatMethods.previewDataFetched,
              onSendPressed: _chatMethods.sendMessage,
              user: _chatMethods.user,
              imageHeaders: _chatMethods.storageHeaders,
              onMessageVisibilityChanged:
                  _chatMethods.handleMessageVisibilityChanged,
              onEndReached: _chatController.loadPreviousMessages,
            ),
          AsyncError(:final error) => Center(child: Text(error.toString())),
          _ => const Center(child: CircularProgressIndicator()),
        });
  }
}
