import 'package:centicbids/common/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

class MockUser extends Mock implements User {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseUser extends Mock implements User {}
class MockAuthResult extends Mock implements UserCredential {}


final MockUser _mockUser = MockUser();

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   Stream<User> authStateChanges() {
//     return Stream.fromIterable([
//       _mockUser,
//     ]);
//   }
// }


void main() {
  setUp((){

  });
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  BehaviorSubject<MockFirebaseUser> user = BehaviorSubject<MockFirebaseUser>();
  Auth auth_repo = Auth(auth: mockFirebaseAuth);
  when(auth_repo.auth.authStateChanges()).thenAnswer((_){
    return user;
  });

  group("user repository test",(){
    test("sign in with email & password", (){
    });
  });




}
