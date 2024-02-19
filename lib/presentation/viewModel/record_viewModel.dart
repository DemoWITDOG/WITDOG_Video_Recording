import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/model/recording.dart';
import 'package:witdog_recodtester/data/repository/record_repository.dart';

class RecordViewModel with ChangeNotifier {
  final RecordRepository _recordRepository;

  RecordViewModel(this._recordRepository);

  Future<void> petRecordAdd(Recording recording) async {
    try{
      await _recordRepository.petRecordAdd(recording);
    } catch (e) {
      print('Pet Recording Add ViewModel error : $e');

      rethrow;
    }
  }

}