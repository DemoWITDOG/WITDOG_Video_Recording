import 'package:flutter/cupertino.dart';

class PetAddShowDialog {
  late BuildContext context;
  DateTime petBirthDay = DateTime.now();
  late Function(DateTime) onDateTimeChanged; // 추가: 선택된 날짜를 전달할 콜백 함수

  PetAddShowDialog(this.context, {required this.onDateTimeChanged});

  void showDatePickerDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: petBirthDay,
            mode: CupertinoDatePickerMode.date,
            maximumYear: DateTime.now().year,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (DateTime birthDay) {
              // 추가: 선택된 날짜를 콜백 함수를 통해 전달
              onDateTimeChanged(birthDay);
            },
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  String myPetAge(DateTime selectedDate) {
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
}