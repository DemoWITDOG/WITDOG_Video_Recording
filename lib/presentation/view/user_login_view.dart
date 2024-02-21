import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/dataSource/user_data_source.dart';
import 'package:witdog_recodtester/presentation/res/media_res.dart';
import 'package:witdog_recodtester/presentation/view/record_home_view.dart';
import 'package:witdog_recodtester/presentation/view/user_view.dart';
import 'package:witdog_recodtester/presentation/viewModel/user_viewModel.dart';

import '../../data/repository/user_repository.dart';

class UserLoginView extends StatefulWidget {
  @override
  _UserLoginViewState createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {
  late UserDataSource userDataSource;
  late UserRepository userRepository;
  late UserViewModel viewModel;

  @override
  initState() {
    super.initState();
    userDataSource = UserDataSource();
    userRepository = UserRepository(userDataSource);
    viewModel = UserViewModel(userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserAddView(
                  viewModel: viewModel,
                ),
              ),
            );
          },
          child: SingleChildScrollView(
            child:
          Center(
            child: Column(
              children: [
                SizedBox(height: 220),
                Image.asset(
                  MediaRes.logoImage,
                  width: 170,
                  height: 60,
                ),
                SizedBox(height: 20,),
                Text(
                  '체험단에 참여해주셔서 감사합니다.',
                  style: TextStyle(
                    fontSize: MediaRes.fontSize16,
                    fontWeight: MediaRes.mediumBold,
                  ),
                ),
                SizedBox(height: 41),
                Container(
                  width: 328,
                  child: TextField(
                    //controller: _phoneNumberController,
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
                SizedBox(height: 9),
                ElevatedButton(onPressed: () {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(328, 56),
                        backgroundColor: Color(MediaRes.mugwort),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    child: Text('로그인하기',
                    style: TextStyle(color: Color(MediaRes.whiteColor)),)),
                SizedBox(height: 32),
                Text(
                  '체험단 가입하기',
                  style: TextStyle(
                    //decoration: TextDecoration.underline,
                    color: Color(MediaRes.blueColor),
                  ),
                ),
              ],
            ),
          ),
          ),
      ),

    );
  }
}
