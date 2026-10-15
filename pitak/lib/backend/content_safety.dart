import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class ContentSafety {
  static CollectionReference<Map<String, dynamic>>? get _blocks {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return uid == null
        ? null
        : FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('blocks');
  }

  static Stream<Set<String>> blockedUsers() =>
      _blocks?.snapshots().map(
            (snapshot) => snapshot.docs.map((doc) => doc.id).toSet(),
          ) ??
      Stream.value(<String>{});

  static Stream<List<T>> filterStream<T>(
          Stream<List<T>> source, Iterable<String> Function(T) authors) =>
      Rx.combineLatest2<List<T>, Set<String>, List<T>>(
        source,
        blockedUsers(),
        (items, blocked) => items
            .where((item) => !authors(item).any(blocked.contains))
            .toList(),
      );

  static Future<List<T>> filterOnce<T>(
      Future<List<T>> source, Iterable<String> Function(T) authors) async {
    final items = await source;
    final blocked = await blockedUsers().first;
    return items.where((item) => !authors(item).any(blocked.contains)).toList();
  }

  static Future<void> block(DocumentReference author) async {
    final blocks = _blocks;
    if (blocks == null) throw StateError('Для блокировки необходимо войти');
    if (author.id == FirebaseAuth.instance.currentUser?.uid)
      throw StateError('Нельзя заблокировать себя');
    await blocks
        .doc(author.id)
        .set({'createdAt': FieldValue.serverTimestamp()});
  }

  static Future<bool> confirmBlock(
      BuildContext context, DocumentReference author) async {
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: const Text('Заблокировать пользователя?'),
              content: const Text(
                  'Его объявления и переписка будут скрыты. Он не сможет отправлять вам новые сообщения.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Отмена')),
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('Заблокировать')),
              ],
            ));
    if (confirmed != true || !context.mounted) return false;
    try {
      await block(author);
      return true;
    } catch (_) {
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Не удалось заблокировать пользователя. Попробуйте ещё раз.')));
      return false;
    }
  }

  static Future<void> reportChat(BuildContext context, DocumentReference author,
      DocumentReference? chat) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: const Text('Пожаловаться на пользователя?'),
              content: const Text(
                  'Жалоба и ссылка на переписку будут отправлены модератору.'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Отмена')),
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('Отправить')),
              ],
            ));
    if (confirmed != true || !context.mounted) return;
    try {
      await FirebaseFirestore.instance.collection('disput').add({
        'idUser': FirebaseFirestore.instance.collection('users').doc(uid),
        'reportedUser': author,
        if (chat != null) 'chat': chat,
        'text':
            'Жалоба на пользователя ${author.id}. Переписка: ${chat?.id ?? "не создана"}.',
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Жалоба отправлена модератору')));
    } catch (_) {
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Не удалось отправить жалобу. Попробуйте ещё раз.')));
    }
  }
}
