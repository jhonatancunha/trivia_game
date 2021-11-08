from collections import defaultdict

# ENTITIES
from entities.player import Player
from entities.countdown import CountDown

class Room():
  def __init__(self, key, sio):
    self.key = key
    self.players = defaultdict(Player)
    self.sio = sio
    self.countdown = CountDown(60, self.sio, 'timer', self.key)


  def start_timer(self):
    # thread = 'this thread was stopped'

    if self.countdown.get_started() == False:
      self.countdown.set_started(True)
      # thread = self.sio.start_background_task(target=self.countdown.start)
      self.sio.start_background_task(target=self.countdown.start)
    # print(thread)

  def set_key(self, key):
    self.key = key
  
  def set_player(self, sid, player):
    self.players[sid] = player

    if len(self.players) >= 2:
      self.start_timer()
  
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
    
    if len(self.players) < 2:
      self.countdown.stop()
      self.sio.emit('stopCountDown', room=self.key)
