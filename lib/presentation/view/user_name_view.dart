import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:witdog_recodtester/data/model/user.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: '실명을 입력해 주세요',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addUser(
                      User(id: '',
                          userId: userId,
                          userName: _nameController.text,
                          userBank: '',
                          userAccountNumber: '',
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
                child: Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}