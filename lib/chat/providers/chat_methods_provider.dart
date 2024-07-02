// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_supabase_chat_core/flutter_supabase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

part 'chat_methods_provider.g.dart';

@riverpod
ChatMethods chatMethods(
    ChatMethodsRef ref, SupabaseChatController controller, types.Room room) {
  return ChatMethods(
    controller: controller,
    room: room,
  );
}

class ChatMethods {
  final SupabaseChatController controller;
  final types.Room room;
  final String buket = 'chats_assets';

  ChatMethods({required this.controller, required this.room});

  Future<FilePickerResult?> pickFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );
  }

  Future<void> handlePickedFile(FilePickerResult? pickerResults) async {
    if (pickerResults != null && pickerResults.files.single.bytes != null) {
      try {
        final bytes = pickerResults.files.single.bytes;
        final name = pickerResults.files.single.name;
        final mimeType = lookupMimeType(name, headerBytes: bytes);
        final reference = await Supabase.instance.client.storage
            .from(buket)
            .uploadBinary('${room.id}/${const Uuid().v1()}-$name', bytes!,
                fileOptions: FileOptions(contentType: mimeType));
        final url =
            '${Supabase.instance.client.storage.url}/object/authenticated/$reference';
        final message = types.PartialFile(
          mimeType: mimeType,
          name: name,
          size: pickerResults.files.single.size,
          uri: url,
        );

        SupabaseChatCore.instance.sendMessage(message, room.id);
      } on PostgrestException catch (e) {
        throw PostgrestException(message: e.message, code: e.code);
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  void handleMessageVisibilityChanged(types.Message message,bool visible) async {
    if (message.status != types.Status.seen &&
        message.author.id != SupabaseChatCore.instance.supabaseUser!.id) {
      await SupabaseChatCore.instance.updateMessage(
        message.copyWith(status: types.Status.seen),
        room.id,
      );
    }
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
  }

  Future<void> handlePickedImage(XFile? pickedResults) async {
    if (pickedResults != null) {
      final bytes = await pickedResults.readAsBytes();
      final size = bytes.length;
      final image = await decodeImageFromList(bytes);
      final name = pickedResults.name;
      final mimeType = lookupMimeType(name, headerBytes: bytes);
      try {
        final reference = await Supabase.instance.client.storage
            .from(buket)
            .uploadBinary('${room.id}/${const Uuid().v1()}-$name', bytes,
                fileOptions: FileOptions(contentType: mimeType));
        final url =
            '${Supabase.instance.client.storage.url}/object/authenticated/$reference';
        final message = types.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: url,
          width: image.width.toDouble(),
        );
        SupabaseChatCore.instance.sendMessage(
          message,
          room.id,
        );
      } on PostgrestException catch (e) {
        throw PostgrestException(message: e.message, code: e.code);
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  Map<String, String> get storageHeaders => {
        'Authorization':
            'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken}',
      };

  types.User get user => types.User(
        id: SupabaseChatCore.instance.supabaseUser!.id,
      );
  void messageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      final client = http.Client();
      final request =
          await client.get(Uri.parse(message.uri), headers: storageHeaders);
      final result = await FileSaver.instance.saveFile(
        name: message.uri.split('/').last,
        bytes: request.bodyBytes,
      );
      await OpenFilex.open(result);
    }
  }

  Future<void> previewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) async {
    final updatedMessage = message.copyWith(previewData: previewData);

    await SupabaseChatCore.instance.updateMessage(updatedMessage, room.id);
  }

  void sendMessage(types.PartialText message) {
    SupabaseChatCore.instance.sendMessage(
      message,
      room.id,
    );
  }
}
