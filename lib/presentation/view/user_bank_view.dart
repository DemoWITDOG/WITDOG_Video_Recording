import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/model/user.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/user_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/user_viewModel.dart';

class UserBankView extends StatelessWidget {
  final UserViewModel viewModel;
  final String userName;
  final String userId;

  UserBankView(
      {required this.viewModel, required this.userName, required this.userId});

  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding:EdgeInsets.zero,
                child: Text(
                  '계좌번호를 입력해 주세요',
                  style: TextStyle(
                    fontSize: MediaRes.fontSize28,
                    fontWeight: MediaRes.bold,
                  ),
                ),),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 159,
                    child: TextField(
                      controller: _bankController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                          BorderSide(color: Color(MediaRes.whiteGrayColor)),
                        ),
                        hintText: '은행명 입력',
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
                  SizedBox(width: 10),
                  Container(
                    width: 159,
                    child: TextField(
                      controller: _accountNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        BorderSide(color:Color(MediaRes.whiteGrayColor)),
                      ),
                        hintText: '예금주명 입력',
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
                ],
              ),
              SizedBox(height: 9),
              Container(
                child: TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      BorderSide(color: Color(MediaRes.whiteGrayColor)),
                    ),
                    hintText: '계좌번호를'+' -'+'없이 입력해주세요',
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.addUser(User(
                    id: '',
                    userId: userId,
                    userName: userName,
                    userBank: _bankController.text,
                    userAccountNumber: _accountController.text,
                    accountHolder: _accountNameController.text,
                    createdAt: '',
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Container(),
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
