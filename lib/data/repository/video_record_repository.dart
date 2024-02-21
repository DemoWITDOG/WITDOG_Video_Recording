import 'package:witdog_recodtester/data/dataSource/video_record_data_source.dart';
import 'package:witdog_recodtester/data/model/video_recording.dart';

class RecordRepository {
  final VideoRecordDataSource _recordDataSource;

  RecordRepository(this._recordDataSource);

  Future<void> petRecordAdd(VideoRecording recording) async{
    try {
      await _recordDataSource.petRecordAdd(recording);
    } catch (e) {
      print('Pet Recording Add Repository errer : $e');

      rethrow;
    }
  }
}