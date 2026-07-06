import 'package:flutter_tutorial_first_sample_project/services/auth/auth_exceptions.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_provider.dart';
import 'package:flutter_tutorial_first_sample_project/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('It should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });
    test('Cannot log out if not Initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });
    test('should be able to initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    
    test('User should be able to initialized', () {
      expect(provider.currentUser, null);
    });

    test(
      'should be able to initialize in less than 4 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 4)),
    );

    test('Create user should delegate to login function', () async {
      final badEmailUser = await provider.createUser(
        email: 'sukrethom2000@gmail.com',
        password: 'sukreth',
      );
      expect(badEmailUser, throwsA(const TypeMatcher<UserNotFountException>()));

      final badPasswordUser = await provider.createUser(
        email: 'someone@bar.com',
        password: 'foobar',
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(email: 'foo', password: 'bar');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, user);
    });

    test('Logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be able to logout and login again', () async {
      await provider.logOut();
      await provider.logIn(email: 'foobar@gmail.com', password: 'password');
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    Future.delayed(Duration(seconds: 3));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'suk@gmail.com') throw UserNotFountException();
    if (password == 'sukreth') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFountException();
    await Future.delayed(Duration(seconds: 3));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFountException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
