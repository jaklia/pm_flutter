import 'package:pm_flutter/bloc/room/room_repository.dart';
import 'package:pm_flutter/models/room.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class RoomBloc {
  final _repository = RoomRepository();
  final _rooms = BehaviorSubject<List<Room>>.seeded([]);

  ValueObservable<List<Room>> get rooms {
    return _rooms.stream;
  }

  Future<void> getRooms() async {
    var newRooms = await _repository.getRooms();
    _rooms.sink.add(newRooms);
  }

  void dispose() {
    _rooms.close();
  }
}
