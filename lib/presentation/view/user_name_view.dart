import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/user_bank_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/user_viewModel.dart';

class UserNameView extends StatelessWidget {
  final UserViewModel viewModel;
  final String userId;
  final Logger logger = Logger();

  UserNameView({required this.viewModel, required this.userId});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  '이름을 입력해 주세요',
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      BorderSide(color: Color(MediaRes.whiteGrayColor)),
                    ),
                    hintText: '실명을 입력해 주세요',
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
                  await viewModel.addUser(
                      User(id: '',
                          userId: userId,
                          userName: _nameController.text,
                          userBank: '',
                          userAccountNumber: '',
                          accountHolder: '',
                          createdAt: '')
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserBankView(viewModel: viewModel, userId: userId, userName: _nameController.text, ),
                    ),
                  );
                  logger.i('사용자 추가 완료: ${_nameController.text}');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(328, 56),
                  backgroundColor: Color(MediaRes.mugwort),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),),
                child: Text('다음',
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