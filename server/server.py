import socket
import os
from _thread import *

ServerSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = '127.0.0.10'
port = 2004
ThreadCount = 0
players = []

try:
    ServerSocket.bind((host, port))
except socket.error as e:
    print(str(e))

print('Socket is listening..')
ServerSocket.listen(5)

def broadcast(message):
    for client in players:
        client.send(message.encode('utf-8'))

def threaded_client(connection):
    connection.send(str.encode('Welcome to the Server\n'))
    while True:
        data = connection.recv(2048)
        reply = 'Server Says: ' + data.decode('utf-8')
        if not data:
            break
        print(players)
        broadcast(reply)
        connection.sendall(str.encode(reply))
    connection.close()

while True:
    Client, address = ServerSocket.accept()
    print('Connected to: ' + address[0] + ':' + str(address[1]))
    players.append(Client)
    start_new_thread(threaded_client, (Client, ))
    ThreadCount += 1
    print('Thread Number: ' + str(ThreadCount))
ServerSocket.close()