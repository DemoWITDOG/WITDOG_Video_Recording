import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:witdog_recodtester/data/dataSource/user_data_source.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/utils/constants.dart';

class PetAddDataSource {
  final Logger _logger = Logger();

  XFile? image;
  User? user;
  String petName = '';
  String selectedBreed = '';
  String selectedFurColor = '';
  String selectedGender = '';
  late DateTime petBirthDay;

  PetAddDataSource({
    required this.petName,
    required this.selectedBreed,
    required this.selectedFurColor,
    required this.selectedGender,
    required this.petBirthDay,
  });

  Future<void> addPetToDatabase(
      {required String petName,
      required String selectedBreed,
      required String selectedFurColor,
      required String selectedGender,
      required DateTime petBirthDay,
      XFile? image,
      required User user}) async {
    try {
      final userId = await UserDataSource().getUserId(user!);

      String petAge = myPetAge(petBirthDay);
      print('Pet Age: $petAge');

      String petPhone = await saveToDatabase(
        selectedGender: selectedGender,
        selectedPetAge: petAge,
        selectedFurColor: selectedFurColor,
        selectedBreed: selectedBreed,
      );

      Uint8List? imageBytes;
      if (image != null) {
        imageBytes = await image!.readAsBytes();
      }

      String? imageUrl;
      if (imageBytes != null) {
        imageUrl = await uploadImageAndGetUrl(imageBytes, user!);
      }

      await addPet(
        petName: petName,
        petImages: imageBytes,
        // 이미지를 Uint8List로 전달
        petBreed: selectedBreed,
        petColor: selectedFurColor,
        petGender: selectedGender,
        petAge: petAge,
        petPhone: petPhone,
        userId: userId,
      );
    } catch (error) {
      print('Error adding pet: $error');
      rethrow;
    }
  }

  Future<void> addPet({
    required String petName,
    required Uint8List? petImages, // 이미지를 Uint8List로 변경
    required String petBreed,
    required String petGender,
    required String petPhone,
    required String petColor,
    required String petAge,
    required String userId,
  }) async {
    try {
      String encodedImages = _encodeImages(petImages ?? Uint8List(0));

      // Add_UserPet 테이블에 데이터 추가
      final response = await supabase.from('pet_add').upsert([
        {
          'users_id': userId,
          'pet_images': encodedImages,
          'pet_name': petName,
          'pet_breed': petBreed,
          'pet_gender': petGender,
          'pet_age': petAge,
          'pet_phone': petPhone,
          'pet_color': petColor,
        }
      ]);

      print(response);

      if (response != null && response.error != null) {
        throw response.error!;
      }
    } catch (error) {
      print('Error adding pet: $error');
      rethrow;
    }
  }

  static Uint8List _decodeImages(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return Uint8List(0);
    }

    try {
      Uint8List decoded = base64Decode(base64String);
      print('Decoded data: $decoded');
      return decoded ?? Uint8List(0);
    } catch (e) {
      print('Error decoding images: $e');
      return Uint8List(0);
    }
  }

  static String _encodeImages(Uint8List images) {
    return base64Encode(images);
  }

  Future<String?> uploadImageAndGetUrl(Uint8List imageBytes, User user) async {
    try {
      final imageUrl = 'data:image/jpeg;base64,${base64Encode(imageBytes)}';
      final userId = await UserDataSource().getUserId(user);

      print('Image URL: $imageUrl');

      final response = await supabase.from('pet_images').upsert([
        {
          'user_id': userId,
          'pet_images': imageUrl,
        }
      ]);
      print('images response : $response');

      if (response != null) {
        print('Error saving profile and image data: ${response.message}');
      } else {
        print('Profile and image data were saved successfully.');
      }
    } catch (error) {
      print('An error occurred while saving profile and image data: $error');
    }
  }

  myPetAge(DateTime selectedDate) {
    DateTime nowDate = DateTime.now();
    int age = nowDate.year - selectedDate.year;
    int month1 = nowDate.month;
    int month2 = selectedDate.month;

    if (month1 < month2) {
      age--;
    }
    if (month1 == month2) {
      int day1 = nowDate.day;
      int day2 = selectedDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }

  Future<String> saveToDatabase({
    required String selectedGender,
    required String selectedPetAge,
    required String selectedFurColor,
    required String selectedBreed,
  }) async {
    try {
//성,종,나이,모색
      String genderCode = (selectedGender == '암컷')
          ? 'A'
          : (selectedGender == '수컷')
              ? 'B'
              : 'C';

//종 코드
      Map<String, String> breedNCode = {
        '닥스훈트': 'A',
        '도베르만': 'B',
        '라사압소': 'C',
        '리트리버': 'D',
        '말티즈': 'E',
        '보더콜리': 'F',
        '불도그': 'G',
        '블러드하운드': 'H',
        '비글': 'I',
        '비숑': 'J',
        '스피츠': 'K',
        '시바견': 'L',
        '시츄': 'M',
        '웰시코기': 'N',
        '진돗개': 'O',
        '치와와': 'P',
        '퍼그': 'Q',
        '포메라니안': 'R',
        '푸들': 'S',
        '믹스견': 'T',
        '달마시안': 'U',
        '사모예드': 'V'
      };

      String breedCode = breedNCode[selectedBreed] ?? 'W';
//펫 나이에 따른 코드부여
      String age = selectedPetAge;
      print('개나이 : $age');

      String ageCode = '';

      switch (age) {
        case '0':
          ageCode = 'A';
          break;
        case '1':
          ageCode = 'B';
          break;
        case '2':
          ageCode = 'C';
          break;
        case '3':
          ageCode = 'D';
          break;
        case '4':
          ageCode = 'E';
          break;
        case '5':
          ageCode = 'F';
          break;
        case '6':
          ageCode = 'G';
          break;
        case '7':
          ageCode = 'H';
          break;
        case '8':
          ageCode = 'I';
          break;
        case '9':
          ageCode = 'J';
          break;
        default:
          ageCode = 'K';
          break;
      }
      print('ageCode : $ageCode');

      Map<String, String> furColr = {
        '크림색': 'A',
        '검은색': 'B',
        '금색': 'C',
        '빨간색': 'D',
        '블루말색': 'E',
        '연갈색': 'F',
        '은색': 'G',
        '진갈색': 'H',
        '진회색': 'I',
      };
      String furColorCode = furColr[selectedFurColor] ?? 'U';

      String petPhone =
          '$genderCode$breedCode$furColorCode$ageCode-${generateRandomNumber()}-${generateRandomNumber1()}';

      return petPhone;
    } catch (error) {
      print('Error saving to database: $error');
      rethrow;
    }
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

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        // 이미지가 선택된 경우에만 할당
        image = pickedImage;
      } else {
        // 이미지 선택이 취소된 경우에 대한 처리
        print('Image selection canceled');
      }
    } catch (error) {
      print('Error picking image: $error');
    }
  }

  Future<void> _onAddButtonClicked() async {
    try {
      await _pickImage(); // 이미지 선택 추가

      if (image == null) {
        // 이미지가 선택되지 않은 경우 예외 처리
        print('Error: Image not selected');
        return;
      }

      final imageBytes = await image!.readAsBytes();

      if (imageBytes == null) {
        // 이미지 바이트가 없는 경우 예외 처리
        print('Error: Image bytes are null');
        return;
      }

      // 이미지를 데이터베이스에 업로드하고 URL 가져오기
      await uploadImageAndGetUrl(imageBytes!, user!);

      // 나머지 코드 작성...
    } catch (error) {
      print('Error adding pet: $error');
    }
  }
}
