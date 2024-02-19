import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/view/user_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/user_viewModel.dart';

class UserBankView extends StatelessWidget {
  final UserViewModel viewModel;
  final String userName;
  final String userId;

  UserBankView({required this.viewModel, required this.userName, required this.userId});

  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

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
                controller: _bankController,
                decoration: InputDecoration(
                  labelText: '은행',
                ),
              ),
              TextField(
                controller: _accountController,
                decoration: InputDecoration(
                  labelText: '계좌번호',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addUser(
                      User(id: '',
                          userId: userId,
                          userName: userName,
                          userBank: _bankController.text,
                          userAccountNumber: _accountController.text,
                          createdAt: '',)
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Container(
                      ),
                    ),
                  );
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