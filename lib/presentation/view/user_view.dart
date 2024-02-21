import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/user_name_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/user_viewModel.dart';

class UserAddView extends StatelessWidget {
  final UserViewModel viewModel;

  UserAddView({required this.viewModel});

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  '전화번호를 입력해 주세요',
                  style: TextStyle(
                    fontSize: MediaRes.fontSize28,
                    fontWeight: MediaRes.bold,
                  ),
                ),
              ),
              SizedBox(height: 100),
              Container(
                width: 328,
                child: TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(MediaRes.whiteGrayColor)),
                    ),
                    hintText: '전화번호를' + '-' + '없이 입력해 주세요',
                    hintStyle:
                        TextStyle(color: Color(MediaRes.whiteGrayTextColor)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(MediaRes.whiteGrayTextColor),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(MediaRes.whiteGrayTextColor),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 41),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addUser(User(
                      id: '',
                      userId: _phoneNumberController.text,
                      userName: '',
                      userBank: '',
                      userAccountNumber: '',
                      accountHolder: '',
                      createdAt: ''));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserNameView(
                          viewModel: viewModel,
                          userId: _phoneNumberController.text),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(328, 56),
                    backgroundColor: Color(MediaRes.mugwort),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: Text(
                  '다음',
                  style: TextStyle(
                    color: Color(MediaRes.whiteColor),
                    fontSize: MediaRes.fontSize12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
