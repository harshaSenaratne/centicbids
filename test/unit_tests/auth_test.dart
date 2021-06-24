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
  Auth authRepo = Auth(auth: mockFirebaseAuth);
  when(authRepo.auth.authStateChanges()).thenAnswer((_){
    return user;
  });

  group("user repository test",(){
    test("sign in with email & password", () async{
      String result = await authRepo.signIn(email: "harsha@gmail.com",password: "harsha@123");
      expect(result, "Success");
    });

    test("sign up with email & password", () async{
      String result = await authRepo.signIn(email: "demouser@gmail.com",password: "demo@123");
      expect(result, "Success");
    });

  });




}
