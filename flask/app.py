from flask import Flask
from flask_socketio import SocketIO, emit

app = Flask(__name__)
io = SocketIO(app)

@app.route("/")
def hello_word():
  return "<p>Hello World</p>"

@io.on('sendChatMessage')
def send_chat_message_handler(msg):
  emit('returnMessage', msg)

if __name__ == "__main__":
  io.run(app, host='127.0.0.1', port=5000, debug=True)