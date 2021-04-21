import 'package:pm_flutter/bloc/room/room_provider.dart';
import 'package:pm_flutter/models/room.dart';

class RoomRepository {
  final _provider = RoomProvider();

  Future<List<Room>> getRooms() async => await _provider.getRoomList();
}
