import 'package:logger/logger.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/utils/constants.dart';

class UserDataSource {
  final Logger _logger = Logger();

  Future<void> addUser(User user) async {
    try {
      DateTime currentTime = DateTime.now();

      final response = await supabase.from('users').upsert([
        {
          'user_id': user.userId,
          'user_name': user.userName,
          'user_bank': user.userBank,
          'user_account_number': user.userAccountNumber,
          'created_at': currentTime.toIso8601String(),
        }
      ]);

      _logger.i('UserDataSource add User data : $response');

      if (response != null) {
        print('Supabase error: $response');
      } else {
        print('User Add successfully: $response');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> loginUser(User user) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        phone: user.userId,
        password: '',
      );

      if (response != null) {
        print('Supabase error: $response');
      } else {
        print('User logged in successfully: $response');
        // 로그인 성공 후 추가 작업 수행
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}