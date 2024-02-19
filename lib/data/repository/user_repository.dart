import 'package:witdog_recodtester/data/dataSource/user_data_source.dart';
import 'package:witdog_recodtester/data/model/user.dart';

class UserRepository {
  final UserDataSource _dataSource;

  UserRepository(this._dataSource);

  Future<void> addUser(User user) async {
    try {
      await _dataSource.addUser(user);
    } catch (e) {
      print('Add User Repository error : $e');

      rethrow; // 예외를 다시 던져서 ViewModel에서 처리할 수 있도록 함
    }
  }

  Future<void> loginUser(User user) async {
    try {
      await _dataSource.loginUser(user);
    } catch (e) {
      print('Login User Repository error : $e');

      rethrow;
    }
  }
}