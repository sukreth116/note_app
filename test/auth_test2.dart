import 'package:flutter_tutorial_first_sample_project/services/auth/auth_exceptions.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_provider.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    late MockAuthProvider provider;

    setUp(() {
      provider = MockAuthProvider();
    });

    test('Should not be initialized at start', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if not initialized', () async {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Should initialize properly', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('Current user should be null after initialization', () async {
      await provider.initialize();
      expect(provider.currentUser, null);
    });

    test(
      'Should initialize within 4 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 4)),
    );

    test('Create user should delegate to login function', () async {
      await provider.initialize();

      // ❌ Invalid email
      await expectLater(
        provider.createUser(email: 'wrong@email.com', password: 'password123'),
        throwsA(const TypeMatcher<UserNotFountException>()),
      );

      // ❌ Wrong password
      await expectLater(
        provider.createUser(email: 'suk@gmail.com', password: 'wrongpass'),
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      // ✅ Valid user
      final user = await provider.createUser(
        email: 'suk@gmail.com',
        password: 'sukreth',
      );

      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Email verification should update user state', () async {
      await provider.initialize();

      await provider.createUser(email: 'suk@gmail.com', password: 'sukreth');

      await provider.sendEmailVerification();

      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should log out properly', () async {
      await provider.initialize();

      await provider.createUser(email: 'suk@gmail.com', password: 'sukreth');

      await provider.logOut();
      expect(provider.currentUser, null);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();

    if (email != 'suk@gmail.com') {
      throw UserNotFountException();
    }

    if (password != 'sukreth') {
      throw WrongPasswordAuthException();
    }

    const user = AuthUser(isEmailVerified: false, email: 'foo@bar.com');
    _user = user;
    return user;
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFountException();

    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFountException();

    _user = const AuthUser(isEmailVerified: true, email: 'foo@bar.com');
  }
}
