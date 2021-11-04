import jsons
from entities.server import Server
from entities.room import Room
from entities.player import Player

#ENTITES
# create a Socket.IO server
server = Server()
sio = server.get_sio()
room = Room('123')

    
# Adicionar jogador no quarto
@sio.on('join') 
def join(sid, environ):
  nickname = environ.get('nickname')
  score = environ.get('score')

  # Adicionando player ao quarto
  new_player = Player(sid, nickname, score, room.get_key())
  room.set_player(new_player.get_sid(), new_player)
  sio.enter_room(sid, room.get_key())

  sio.save_session(sid, {'room': room.get_key()})
  sio.emit('newPlayer', jsons.dumps({"players": room.get_all_players()}), to=room.get_key())
  sio.emit('messageJoin', jsons.dumps({"message": " entrou na sala.", "nickname": nickname, "type":"join"}), room=room.get_key())


@sio.on('left')
def left(sid):
  session = sio.get_session(sid)
  room_key = session['room']
  nickname = session['nickname']
  sio.leave_room(sid, room_key)

  room.remove_player(sid)

  sio.emit('personLeaveTheGame', jsons.dumps({"message": " saiu da sala.", "nickname": nickname, "type":"leave"}), room=room_key)


@sio.on('sendChatMessage')
def send_chat_message_handler(sid, environ):
  message = environ
  session = sio.get_session(sid)
  nickname = session['nickname']
  sio.emit('messageChat', jsons.dumps({"message": message, "nickname": nickname, "type":"chat"}), room=room.get_key())


app = server.start()
