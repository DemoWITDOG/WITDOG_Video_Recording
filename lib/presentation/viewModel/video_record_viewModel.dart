import 'package:flutter/material.dart';
import 'package:witdog_recodtester/data/model/video_recording.dart';
import 'package:witdog_recodtester/data/repository/video_record_repository.dart';

class RecordViewModel with ChangeNotifier {
  final RecordRepository _recordRepository;

  RecordViewModel(this._recordRepository);

  Future<void> petRecordAdd(VideoRecording recording) async {
    try{
      await _recordRepository.petRecordAdd(recording);
    } catch (e) {
      print('Pet Recording Add ViewModel error : $e');

      rethrow;
    }
  }

}