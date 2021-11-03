from typing import DefaultDict

class Server():
  
  def __init__(self):
    self.rooms = DefaultDict(dict)

  def get_room(self, key):
    return self.rooms[key]

  def get_all_rooms(self):
    return self.rooms

  def set_room(self, room):
    self.rooms[room.key] = room

  def remove_room(self, key):
    self.rooms.pop(key)
