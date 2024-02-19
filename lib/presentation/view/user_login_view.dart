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
        child: Center(
          child: Column(
            children: [
              Image.asset(
                MediaRes.serviceInfoImage,
                width: 170,
                height: 60,
              ),
              Text(
                '체험단에 참여해주세서 감사합니다.',
                style: TextStyle(
                  fontSize: MediaRes.fontSize16,
                  fontWeight: MediaRes.mediumBold,
                ),
              ),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => RecordHomeView()),
                );
              },
                  child: Text('로그인하기')),
              Text(
                '체험단 가입하기',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(MediaRes.blueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
