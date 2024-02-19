import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/data/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository);

  // 필요한 상태 (데이터) 정의
  String _statusMessage = '';
  String get statusMessage => _statusMessage;

  // 사용자 추가 메서드
  Future<void> addUser(User user) async {
    try {
      await _userRepository.addUser(user);
      _statusMessage = 'User added successfully';
      notifyListeners(); // 상태 변경을 알리기 위해 notifyListeners 호출
    } catch (e) {
      _statusMessage = 'Error adding user: $e';
      print('User Add ViewModel Error : $e');
    }
  }

  // 사용자 로그인 메서드
  Future<void> loginUser(User user) async {
    try {
      await _userRepository.loginUser(user);
      _statusMessage = 'User logged in successfully';
      notifyListeners(); // 상태 변경을 알리기 위해 notifyListeners 호출
    } catch (e) {
      _statusMessage = 'Error logging in: $e';
      print('User Login ViewModel Error : $e');
    }
  }
}