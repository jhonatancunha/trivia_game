from entities.server import Server


# CONSTS
ROOM_KEY = '123'

#ENTITES
# create a Socket.IO server
server = Server()
sio = server.get_sio()
server.set_room(ROOM_KEY)
app = server.start()
