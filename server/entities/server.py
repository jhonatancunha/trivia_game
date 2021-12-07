import socketio
from gevent import pywsgi
from geventwebsocket.handler import WebSocketHandler
import jsons
from collections import defaultdict
from entities.room import Room
from entities.player import Player
from rich import inspect

ROOM_KEY = '123'

class Server():
  
  def __init__(self):
    self.sio = socketio.Server(async_mode='gevent', logger=True, engineio_logger=True)
    self.rooms = defaultdict(Room)
    self.sio.on('join', self.join)
    self.sio.on('left', self.left)
    self.sio.on('sendChatMessage', self.send_chat_message_handler)
    self.sio.on('getWord', self.get_word)


  def get_sio(self):
    return self.sio

  def get_room(self, key):
    return self.rooms[key]

  def get_all_rooms(self):
    return self.rooms

  def set_room(self, key):
    room = Room(key, self.sio)
    self.rooms[key] = room

  def remove_room(self, key):
    self.rooms.pop(key)

  def start(self):
    app = socketio.WSGIApp(self.sio)
    pywsgi.WSGIServer(('25.2.227.94', 8080), app, handler_class=WebSocketHandler).serve_forever()
  
  
  # @ssio.on('join') 
  def join(self, sid, environ):
    nickname = environ.get('nickname')
    score = environ.get('score')
    room = self.get_room(ROOM_KEY)

    # Adicionando player ao quarto
    new_player = Player(sid, nickname, score, room.get_key())
    
    
    room.set_player(new_player.get_sid(), new_player)
    self.sio.enter_room(sid, room.get_key())

    self.sio.save_session(sid, {'room': room.get_key()})
    
    self.sio.emit('listOfPlayers', jsons.dumps({"players": room.get_all_players()}), to=room.get_key())
    self.sio.emit('messageJoin', jsons.dumps({"message": " entrou na sala.", "nickname": nickname, "type":"join"}), room=room.get_key())


  # @self.sio.on('left')
  def left(self, sid):
    session = self.sio.get_session(sid)
    room_key = session['room']
    room = self.get_room(room_key)
    player = room.get_player(sid)
    nick_player = player.get_nickname()
    
    
    # Caso jogador da vez sair, iniciar outro round
    if(room.get_sid_round_player() == sid):
      room.start_new_round()
    
    # Removendo player da sala
    self.sio.leave_room(sid, room_key)
    room.remove_player(sid)

    self.sio.emit('listOfPlayers', jsons.dumps({"players": room.get_all_players()}), to=room.get_key())
    self.sio.emit('playerLeaveTheGame', jsons.dumps({"message": " saiu da sala.", "nickname": nick_player, "type":"leave"}), room=room_key)


  # @self.sio.on('sendChatMessage')
  def send_chat_message_handler(self, sid, environ):
    message = environ
    session = self.sio.get_session(sid)
    room_key = session['room']
    room = self.get_room(room_key)
    player = room.get_player(sid)
    
    # inspect(environ, methods=True)
    room.handler_message(message, player)

    

  # @self.sio.on('getWord')
  def get_word(self, sid, environ):
    answer = environ.get('answer').lower()
    theme = environ.get('theme')
    hint = environ.get('hint')

    session = self.sio.get_session(sid)
    room_key = session['room']
    room = self.get_room(room_key)

    room.set_round_word(answer, theme, hint)

