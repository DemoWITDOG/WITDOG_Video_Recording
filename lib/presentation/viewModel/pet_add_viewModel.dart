import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:witdog_recodtester/data/repository/pet_add_repository.dart';
import 'package:witdog_recodtester/data/model/user.dart';

class PetAddViewModel with ChangeNotifier{
  late PetAddRepository _petAddRepository;
  late String randomNumberText;
  late String userEnteredNumberText;
  late bool isRandomMode = true;
  late TextEditingController _controller = TextEditingController();

  // 뷰모델에서 상태를 관리하기 위한 변수들
  late bool isDuplicate = false;
  late String duplicateText = '';

  PetAddViewModel(PetAddRepository petAddRepository);

  // 뷰모델에서 상태를 업데이트하는 함수
  void _updateState(bool isDuplicate, String text) {
    this.isDuplicate = isDuplicate;
    this.duplicateText = text;
  }

  void setControllerText() {
    _controller.text = isRandomMode ? randomNumberText : userEnteredNumberText;
  }

  Future<void> addPet({
    required String petName,
    required String selectedBreed,
    required String selectedFurColor,
    required String selectedGender,
    required DateTime petBirthDay,
    required Uint8List? image,
    required User user,
  }) async {
    try {
      await _petAddRepository.addPet(
        petName: petName,
        selectedBreed: selectedBreed,
        selectedFurColor: selectedFurColor,
        selectedGender: selectedGender,
        petBirthDay: petBirthDay,
        image: image,
        user: user,
      );
    } catch (error) {
      print('Error PetAddViewModel adding pet: $error');
      rethrow;
    }
  }

  // 수정: randomNumberText와 setState 부분을 주석 처리
  void checkForDuplicates() async {
    List<String> lastFourDigitsList = await getPetPhoneLastFourDigits();

    bool isDuplicates =
    lastFourDigitsList.any((digits) => randomNumberText.contains(digits));

    _updateState(
      isDuplicates,
      isDuplicates
          ? '이 번호는 이미 등록되었습니다.'
          : '사용 가능한 번호입니다.',
    );
  }

  // 수정: userEnteredNumberText와 setState 부분을 주석 처리
  void checkForUserEnteredDuplicates() async {
    List<String> userLastFourDigitsList = await getPetPhoneLastFourDigits();

    bool isDuplicates = userLastFourDigitsList
        .any((digits) => userEnteredNumberText.contains(digits));

    _updateState(
      isDuplicates,
      isDuplicates
          ? '이 번호는 이미 등록되었습니다.'
          : '사용 가능한 번호입니다.',
    );
  }

  Future<List<String>> getPetPhoneLastFourDigits() async {
    // supabase.from('Add_UserPet') 대신에 실제 Supabase 쿼리로 변경해야 함
    final response = await _petAddRepository.getUserIdList();

    print('phone list number : $response');

    // pet_phone 값을 추출하여 뒤에서 4자리만 남기고 리스트로 만듦
    List<String> lastFourDigitsList = response.map<String>((pet) {
      String petPhoneValue = pet['pet_phone'];
      print('petPhoneValue : $petPhoneValue');
      print(
          'petPhoneValue.substring(petPhoneValue.length - 4)${petPhoneValue.substring(petPhoneValue.length - 4)}');
      return petPhoneValue.substring(petPhoneValue.length - 4);
    }).toList() ??
        [];

    print('lastFourDigitsList $lastFourDigitsList');

    return lastFourDigitsList;
  }

  String generateRandomNumber1() {
// 4자리 난수 생성
    String randomNum = (Random().nextInt(9000) + 1000).toString();
    return randomNum;
  }

  String generateRandomNumber() {
    String randomNum = (Random().nextInt(9) + 1).toString();
    return randomNum;
  }

}