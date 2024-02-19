import 'package:logger/logger.dart';
import 'package:witdog_recodtester/data/model/recording.dart';
import 'package:witdog_recodtester/presentation/utils/constants.dart';

class RecordDataSource {
  final Logger _logger = Logger();

  Future<void> petRecordAdd(Recording recording) async {
    try {
      DateTime currentTime = DateTime.now();

      final response = await supabase.from('pet_recording').upsert([
        {
          'id': recording.id,
          'petSoundRecord': recording.petSoundRecord,
          'userId': recording.userId,
          'created_at': currentTime.toIso8601String(),
        }
      ]);

      _logger.i('petDataSource add User data : $response');

      if (response != null) {
        print('Supabase error: $response');
      } else {
        print('Pet Record Add successfully: $response');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}