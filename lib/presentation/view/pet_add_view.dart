import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:witdog_recodtester/data/dataSource/pet_add_data_source.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/data/repository/pet_add_repository.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/user_login_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/pet_add_viewModel.dart';
import 'package:witdog_recodtester/presentation/widget/pet_add_show_dialog.dart';

class PetAddView extends StatefulWidget {
  const PetAddView({Key? key}) : super(key: key);

  @override
  State<PetAddView> createState() => _PetAddViewState();
}

class _PetAddViewState extends State<PetAddView> {
  late TextEditingController _controller = TextEditingController();
  late PetAddViewModel _petAddViewModel;
  late String petName;
  String selectedBreed = '';
  String selectedFurColor = '';
  String selectedGender = '';
  DateTime petBirthDay = DateTime.now();
  XFile? image;
  late User user; // User 정보를 어떻게 받아올지에 따라 수정

  String randomNumberText = '';
  String userEnteredNumber = '';
  String randomNumberHistory = '';
  String userEnteredNumberHistory = '';
  String duplicateText = '';
  String userEnteredNumberText = '';
  bool isRandomMode = true;
  bool selectedIsNeutered = false;
  bool isDuplicate = false;


  List<String> dogBreedList = [
    '닥스훈트', '도베르만', '라사압소', '리트리버', '말티즈',
    '보더콜리', '불도그', '블러드하운드', '비글', '비숑',
    '스피츠', '시바견', '시츄', '웰시코기', '진돗개',
    '치와와', '퍼그', '포메라니안', '푸들', '믹스견',
    '달마시안', '사모에드'
  ];
  List<String> dogColor = [
    '크림색', '검은색', '금색', '빨간색', '블루말색',
    '연갈색', '은색', '진갈색', '진회색'
  ];

  @override
  void initState() {
    super.initState();
    _petAddViewModel = PetAddViewModel(PetAddRepository(PetAddDataSource(
      petName: '초코',  // 펫의 이름
      selectedBreed: '닥스훈트',  // 품종
      selectedFurColor: '갈색',  // 털색
      selectedGender: '암컷',  // 성별
      petBirthDay: DateTime(2022, 1, 1),  // 출생일
    )));
  }
  @override
  Widget build(BuildContext context) {
    print('randomNumberHistory : $randomNumberHistory'); // 현재 번호를 이력에 추가)
    print('userEnteredNumberHistory : $userEnteredNumberHistory'); // 현재 번호를 이력에 추가)

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                '반려동물추가',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () async {
                    await _petAddViewModel.addPet(
                        petName: petName,
                        selectedBreed: selectedBreed,
                        selectedFurColor: selectedFurColor,
                        selectedGender: selectedGender,
                        petBirthDay: petBirthDay,
                        image: image != null ? await image?.readAsBytes() : null,
                        user: user,);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Container()),
                      (route) => false, // 모든 이전 루트를 제거하고 새로운 루트만 남김
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      '저장',
                      style: TextStyle(
                        color: Color(0xFF0094FF),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Color(0xFFF0F0F0),
              elevation: 0,
              titleSpacing: 0,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '반려동물 사진 추가',
                      style: TextStyle(
                        color: Color(0xFF7C7C7C),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                Container(
                  width: 184,
                  height: 184,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await _petAddViewModel.addPet(
                        petName: petName,
                        selectedBreed: selectedBreed,
                        selectedFurColor: selectedFurColor,
                        selectedGender: selectedGender,
                        petBirthDay: petBirthDay,
                        image: image != null ? await image?.readAsBytes() : null,
                        user: user,
                      );
                    },
                    child: Stack(
                      children: [
                        // gradation
                        Positioned(
                          top: 0.67 * 184,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFC1C1C1),
                                  Colors.grey,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        if (image != null)
                          Positioned(
                            child: Image.file(
                              File(image!.path),
                              width: 184,
                              height: 184,
                              fit: BoxFit.fill, // 이미지를 완전히 채우도록 설정
                            ),
                          ),
                        // 디폴트 이미지
                        if (image == null)
                          Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: SvgPicture.asset(
                              'assets/images/profile_images/default_dog_profile.svg',
                              width: 118,
                              height: 118,
                            ),
                          ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 11,
                          child: Center(
                            child: image != null
                                ? Text(
                              '수정하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                                : Text(
                              '추가하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // 텍스트 입력 필드 3개 추가
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              petName = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: '별칭을 입력해 주세요',
                            labelStyle: TextStyle(
                              color: Color(0xffC1C1C1),
                              fontSize: 18,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xffC1C1C1),
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xffE0E0E0),
                                width: 1,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(right: 16.0, left: 16.0, top: 12),
                  child: Container(
                    height: 56, // DropdownButton의 높이 조절
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Color(0xffE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value:
                            selectedBreed.isNotEmpty ? selectedBreed : null,
                            items: dogBreedList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedBreed = value ?? '';
                              });
                            },
                            underline: Container(),
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Color(0xffC1C1C1)),
                            ),
                            hint: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                '반려동물 품종 선택',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffC1C1C1),
                                ),
                              ),
                            ),
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // 암컷 선택 버튼
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 7),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGender = '암컷';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(56),
                            backgroundColor: selectedGender == '암컷'
                                ? Color(0xFF16C077)
                                : Color(0xffE0E0E0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            '암컷',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: selectedGender == '암컷'
                                  ? Colors.white
                                  : Color(0xffC1C1C1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 수컷 선택 버튼
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7, right: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedGender = '수컷';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(56),
                            backgroundColor: selectedGender == '수컷'
                                ? Color(0xFF16C077)
                                : Color(0xffE0E0E0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            '수컷',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: selectedGender == '수컷'
                                  ? Colors.white
                                  : Color(0xffC1C1C1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: selectedIsNeutered,
                          onChanged: (bool? value) {
                            setState(() {
                              selectedIsNeutered = value ?? false;
                            });
                          },
                          visualDensity:
                          VisualDensity(horizontal: -4, vertical: -4),
                        ),
                        Text(
                          '중성화했음',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Column(
                  children: <Widget>[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFFF0F0F0),
                        fixedSize: Size(377, 56),
                        side: BorderSide(
                          color: Color(0xffE0E0E0),
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12))),
                      ),
                      onPressed: () => PetAddShowDialog(context, onDateTimeChanged: (DateTime birthDay) {
                        setState(() => petBirthDay = birthDay);
                      }).showDatePickerDialog(),
                      child: Text(
                        '${petBirthDay.year}/${petBirthDay.month}/${petBirthDay
                            .day}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    //CupertinoButton.filled(child: child, onPressed: onPressed)
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(right: 16.0, left: 16.0, top: 12),
                  child: Container(
                    height: 56, // DropdownButton의 높이 조절
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                      border: Border.all(
                        color: Color(0xffE0E0E0),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: selectedFurColor.isNotEmpty
                                ? selectedFurColor
                                : null,
                            items: dogColor.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedFurColor = value ?? '';
                              });
                            },
                            underline: Container(),
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Color(0xffC1C1C1)),
                            ),
                            hint: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                '반려동물 모색 선택',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xffC1C1C1),
                                ),
                              ),
                            ),
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text(
                        '동물전화번호',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      Text(
                        '원격으로 통신할 수 있는 동물전화번호를 등록합니다.\n끝자리만 선택이 가능해요 예시) ABC-1234-5678',
                        style: TextStyle(
                          color: Color(0xff7C7C7C),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        height: 56,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(fontSize: 20),
                                readOnly: false,
                                onTap: () {
                                  // 필드를 터치할 때 실행할 동작 정의
                                  setState(() {
                                    randomNumberText = '';
                                    userEnteredNumberText = '';
                                    userEnteredNumberHistory = '';
                                    randomNumberHistory = '';
                                    _petAddViewModel.setControllerText();
                                    print('object:$userEnteredNumberText');
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    userEnteredNumberText = value;
                                    randomNumberText = '';
                                    userEnteredNumberHistory = '';
                                    randomNumberHistory = '';
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: '번호입력',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: Color(0xFFDDDDDD), width: 1),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(96, 56),
                              backgroundColor: Color(0xFF16C077),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              print('input random : $randomNumberText');
                              print(
                                  'userEnteredNumberText random : $userEnteredNumberText');
                              print('object:$userEnteredNumberText');

                              if (randomNumberText.isNotEmpty) {
                                // 랜덤번호가 있을 때만 중복확인 수행
                                randomNumberHistory +=
                                    randomNumberText; // 현재 번호를 이력에 추가
                                _petAddViewModel.checkForDuplicates(); // 중복 확인
                              } else if (userEnteredNumberText.isNotEmpty) {
                                // 사용자가 직접 입력한 번호가 있을 때만 중복확인 수행
                                userEnteredNumberHistory +=
                                    userEnteredNumberText; // 사용자가 직접 입력한 번호를 이력에 추가
                                print(
                                    'input userEnter : $userEnteredNumberText');
                                _petAddViewModel.checkForUserEnteredDuplicates(); // 사용자가 직접 입력한 번호에 대한 중복 확인 수행
                              }
                            },
                            child: Text(
                              '중복확인',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(96, 56),
                              backgroundColor: Color(0xFF262121),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                randomNumberText =
                                    _petAddViewModel.generateRandomNumber1();
                              });
                              _petAddViewModel.setControllerText(); // 수정된 부분: 터치할 때 컨트롤러 텍스트 갱신
                              print('랜덤번호 생성: $randomNumberText');
                            },
                            child: Text(
                              '랜덤번호',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaRes.fontSize18,
                                fontWeight: MediaRes.semiBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          duplicateText,
                          style: TextStyle(
                            color: isDuplicate ? Colors.blue : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(56),
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.zero))),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserLoginView()));
                            },
                            child: Container(
                              child: Text(
                                '스킵하기',
                                style: TextStyle(color: Colors.white,
                                    fontSize: 18),
                              ),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}