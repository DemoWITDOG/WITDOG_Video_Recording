import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/view/user_name_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/user_viewModel.dart';

class UserAddView extends StatelessWidget {
  final UserViewModel viewModel;
  UserAddView({required this.viewModel});

  final TextEditingController _phoneNumberController = TextEditingController();


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
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: '전화번호를' + '-' + '없이 입력해 주세요',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addUser(
                      User(id: '',
                          userId: _phoneNumberController.text,
                          userName: '',
                          userBank: '',
                          userAccountNumber: '',
                          createdAt: '')
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserNameView(viewModel: viewModel, userId: _phoneNumberController.text),
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