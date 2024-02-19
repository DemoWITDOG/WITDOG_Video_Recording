import 'package:witdog_recodtester/data/dataSource/record_data_source.dart';
import 'package:witdog_recodtester/data/model/recording.dart';

class RecordRepository {
  final RecordDataSource _recordDataSource;

  RecordRepository(this._recordDataSource);

  Future<void> petRecordAdd(Recording recording) async{
    try {
      await _recordDataSource.petRecordAdd(recording);
    } catch (e) {
      print('Pet Recording Add Repository errer : $e');

      rethrow;
    }
  }
}