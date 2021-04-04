import 'package:pm_flutter/models/room.dart';
import 'package:pm_flutter/utility/network.dart';
import 'package:pm_flutter/utility/urls.dart';

class RoomProvider {
  Future<List<Room>> getRoomList() async {
    var res = await Network.dio.get(Urls.ROOM);
    var rooms = res.data.map((json) => Room.fromJson(json)).toList();
    return rooms;
  }

  Future<List<Room>> getAvailableRooms(DateTime from, DateTime to) async {
    // TODO:  get rooms that are available between the 2 dates
  }
}
