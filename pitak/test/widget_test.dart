import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pitak/auth/base_auth_user_provider.dart';
import 'package:pitak/auth/firebase_auth/firebase_auth_manager.dart';

class TestUser implements BaseAuthUser {
  TestUser({this.error});
  final FirebaseAuthException? error;
  bool deleted = false;
  @override
  bool get loggedIn => !deleted;
  @override
  Future<void> delete() async {
    if (error != null) throw error!;
    deleted = true;
  }
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  tearDown(() => currentUser = null);
  Future<BuildContext> contextFor(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(MaterialApp(home: Builder(builder: (value) {
      context = value;
      return const Scaffold();
    })));
    return context;
  }
  testWidgets('deletion succeeds while the user is still authenticated', (tester) async {
    final context = await contextFor(tester), user = TestUser();
    currentUser = user;
    expect(await FirebaseAuthManager().deleteUser(context), isTrue);
    expect(user.deleted, isTrue);
  });
  testWidgets('signed out deletion does not report success', (tester) async {
    final context = await contextFor(tester);
    expect(await FirebaseAuthManager().deleteUser(context), isFalse);
  });
  testWidgets('reauthentication failure keeps the account and explains the next step', (tester) async {
    final context = await contextFor(tester), user = TestUser(error: FirebaseAuthException(code: 'requires-recent-login'));
    currentUser = user;
    expect(await FirebaseAuthManager().deleteUser(context), isFalse);
    await tester.pump();
    expect(user.deleted, isFalse);
    expect(find.text('Для удаления профиля войдите в аккаунт ещё раз.'), findsOneWidget);
  });
  testWidgets('network failure is visible and does not report deletion', (tester) async {
    final context = await contextFor(tester), user = TestUser(error: FirebaseAuthException(code: 'network-request-failed'));
    currentUser = user;
    expect(await FirebaseAuthManager().deleteUser(context), isFalse);
    await tester.pump();
    expect(user.deleted, isFalse);
    expect(find.text('Не удалось удалить профиль. Попробуйте ещё раз.'), findsOneWidget);
  });
}
