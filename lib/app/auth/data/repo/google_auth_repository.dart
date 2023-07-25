import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/utils/result.dart';
import '../data_sources/google_auth_data_source.dart';

class GoogleAuthRepository {
  static final GoogleAuthRepository _instance =
      GoogleAuthRepository._internal();

  factory GoogleAuthRepository() {
    return _instance;
  }

  GoogleAuthRepository._internal();

  final GoogleAuthDataSource dataSource = GoogleAuthDataSource();

  Future<Result<GoogleSignInAccount>> signIn() async {
    return dataSource.signIn();
  }

  Future<Result<GoogleSignInAccount>> signOut() async {
    return dataSource.signOut();
  }

  Future<bool> isSignedIn() {
    return dataSource.isSignedIn();
  }
}
