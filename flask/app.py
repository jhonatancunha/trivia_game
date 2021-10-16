from flask import Flask
from flask_socketio import SocketIO, emit
from flask_session import Session

app = Flask(__name__)
io = SocketIO(app)
app.config['SESSION_TYPE'] = 'filesystem'
app.config['SECRET_KEY'] = 'triviagame'

@app.route("/")
def hello_word():
  return "<p>Hello World</p>"

@io.on('join')
def join(message):
  print(message)

@io.on('sendChatMessage')
def send_chat_message_handler(msg):
  emit('returnMessage', msg)

if __name__ == "__main__":
  io.run(app, host='127.0.0.1', port=5000, debug=True)