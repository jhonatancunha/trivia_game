from collections import defaultdict

# ENTITIES
from entities.player import Player
from entities.countdown import CountDown

class Room():
  def __init__(self, key, sio):
    self.key = key
    self.players = defaultdict(Player)
    self.sio = sio

  def manage_timer(self):
    cd = CountDown(30, self.sio, 'teste', self.key)
    thread = self.sio.start_background_task(target=cd.start)
    print(thread)

  def set_key(self, key):
    self.key = key
  
  def set_player(self, sid, player):
    self.players[sid] = player

    if len(self.players) >= 2:
      self.manage_timer()
  
  def get_key(self):
    return self.key
  
  def get_all_players(self):
    return self.players
  
  def get_player(self, sid):
    if sid in self.players:
      return self.players[sid]
    else:
      return None
  

  def remove_player(self, sid):
    if sid in self.players:
      del self.players[sid]

