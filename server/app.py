import jsons
from entities.server import Server
from entities.room import Room
from entities.player import Player
from entities.countdown import CountDown


# CONSTS
ROOM_KEY = '123'

#ENTITES
# create a Socket.IO server
server = Server()
sio = server.get_sio()
server.set_room('123')

    
# Adicionar jogador no quarto
@sio.on('join') 
def join(sid, environ):
  nickname = environ.get('nickname')
  score = environ.get('score')
  room = server.get_room(ROOM_KEY)

  # Adicionando player ao quarto
  new_player = Player(sid, nickname, score, room.get_key())
  room.set_player(new_player.get_sid(), new_player)
  sio.enter_room(sid, room.get_key())

  sio.save_session(sid, {'room': room.get_key()})
  
  # cd = CountDown(30, sio, 'teste', ROOM_KEY)
  # thread = sio.start_background_task(target=cd.start)
  
  # print(thread)
  
  sio.emit('listOfPlayers', jsons.dumps({"players": room.get_all_players()}), to=room.get_key())
  sio.emit('messageJoin', jsons.dumps({"message": " entrou na sala.", "nickname": nickname, "type":"join"}), room=room.get_key())
  
  # teste_timer(sio, room.get_key())



@sio.on('left')
def left(sid):
  session = sio.get_session(sid)
  room_key = session['room']
  room = server.get_room(room_key)
  player = room.get_player(sid)

  # Removendo player da sala
  sio.leave_room(sid, room_key)
  room.remove_player(sid)

  sio.emit('listOfPlayers', jsons.dumps({"players": room.get_all_players()}), to=room.get_key())
  sio.emit('playerLeaveTheGame', jsons.dumps({"message": " saiu da sala.", "nickname": player.get_nickname(), "type":"leave"}), room=room_key)


@sio.on('sendChatMessage')
def send_chat_message_handler(sid, environ):
  message = environ
  session = sio.get_session(sid)
  room_key = session['room']
  room = server.get_room(room_key)
  player = room.get_player(sid)

  sio.emit('messageChat', jsons.dumps({"message": message, "nickname": player.get_nickname(), "type": "chat"}), room=room.get_key())


app = server.start()
