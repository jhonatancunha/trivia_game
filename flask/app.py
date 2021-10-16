from typing import IO
from flask import Flask, session
from flask_socketio import SocketIO, emit, join_room, leave_room
from flask_session import Session

app = Flask(__name__)
app.config['SECRET_KEY'] = 'triviagame'
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)
io = SocketIO(app)



@app.route("/")
def hello_word():
  return "<p>Hello World</p>"

@io.on('join')
def join(user):
  session['nickname'] = user['nickname']
  session['score'] = user['score']
  session['room'] = '123'
  join_room('123')
  message = session.get('nickname') + ' entrou na sala.'
  emit('newPersonInGame', {'message': message}, room='123')
  
@io.on('left')
def left(arg):
  room = session.get('room')
  nickname = session.get('nickname')
  leave_room(room)
  session.clear()
  message = nickname + 'saiu da sala.'
  emit('personLeaveTheGame', {'message': message}, rom=room)

@io.on('sendChatMessage')
def send_chat_message_handler(msg):
  emit('returnMessage', msg, room='123')

if __name__ == "__main__":

  io.run(app, host='127.0.0.1', port=5000, debug=True)