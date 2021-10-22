import socketio


#ENTITES

# create a Socket.IO server
sio = socketio.Server(async_mode='gevent', logger=True, engineio_logger=True)
ROOM = '123'


# @sio.event
# def connect(sid, environ, auth):
#     # print('connect ', sid, environ, auth)
#     pass

# @sio.event
# def disconnect(sid):
#     print('disconnect ', sid)
    

@sio.on('join') 
def join(sid, environ):
  nickname = environ.get('nickname')
  score = environ.get('score')
  sio.save_session(sid, {'nickname': nickname, 'score': score, 'room': ROOM})
  sio.enter_room(sid, '123')
  sio.emit('newPlayer', '{"nickname": "%s", "score": "%s"}' % (nickname, score), to=ROOM)
  sio.emit('messageJoin', '{"message": " entrou na sala.", "nickname": "%s", "type":"join"}' % nickname, room=ROOM)
  
@sio.on('left')
def left(sid):
  session = sio.get_session(sid)
  room = session['room']
  nickname = session['nickname']
  sio.leave_room(sid, room)
  sio.emit('personLeaveTheGame', '{"message": " saiu da sala.", "nickname": "%s", "type":"leave"}' % nickname, room=room)


@sio.on('sendChatMessage')
def send_chat_message_handler(sid, environ):
  message = environ
  session = sio.get_session(sid)
  nickname = session['nickname']
  sio.emit('messageChat', '{"message": ": %s", "nickname": "%s", "type":"chat"}' % (message, nickname), room=ROOM)

from gevent import pywsgi
from geventwebsocket.handler import WebSocketHandler
app = socketio.WSGIApp(sio)
pywsgi.WSGIServer(('', 8000), app,
                  handler_class=WebSocketHandler).serve_forever()