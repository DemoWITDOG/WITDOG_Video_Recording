import 'dart:typed_data';
import 'package:witdog_recodtester/data/dataSource/pet_add_data_source.dart';
import 'package:witdog_recodtester/data/dataSource/user_data_source.dart';
import 'package:witdog_recodtester/data/model/user.dart';

class PetAddRepository {
  final PetAddDataSource _dataSource;

  PetAddRepository(this._dataSource);

  Future<String?> addPet({
    required String petName,
    required String selectedBreed,
    required String selectedFurColor,
    required String selectedGender,
    required DateTime petBirthDay,
    required Uint8List? image,
    required User user,
  }) async {
    try {
      final petPhone = await _dataSource.saveToDatabase(
        selectedGender: selectedGender,
        selectedPetAge: _dataSource.myPetAge(petBirthDay),
        selectedFurColor: selectedFurColor,
        selectedBreed: selectedBreed,
      );

      String? imageUrl;
      if (image != null) {
        imageUrl = await _dataSource.uploadImageAndGetUrl(image, user);
      }

      await _dataSource.addPet(
        petName: petName,
        petImages: image,
        petBreed: selectedBreed,
        petGender: selectedGender,
        petPhone: petPhone,
        userId: await UserDataSource().getUserId(user),
        petColor: selectedFurColor,
          petAge: _dataSource.myPetAge(petBirthDay).toString(),
      );

      return imageUrl;
    } catch (error) {
      print('Error adding pet: $error');
      return null;
    }
  }

  getUserIdList() {

  }
}