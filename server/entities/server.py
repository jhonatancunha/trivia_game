import socketio
from gevent import pywsgi
from geventwebsocket.handler import WebSocketHandler
from typing import DefaultDict

class Server():
  
  def __init__(self):
    self.sio = socketio.Server(async_mode='gevent', logger=True, engineio_logger=True)
    self.rooms = DefaultDict(dict)

  def get_sio(self):
    return self.sio

  def get_room(self, key):
    return self.rooms[key]

  def get_all_rooms(self):
    return self.rooms

  def set_room(self, room):
    self.rooms[room.key] = room

  def remove_room(self, key):
    self.rooms.pop(key)

  def start(self):
    app = socketio.WSGIApp(self.sio)
    pywsgi.WSGIServer(('', 8000), app, handler_class=WebSocketHandler).serve_forever()
  