from collections import defaultdict
import jsons

# ENTITIES
from entities.player import Player
from entities.countdown import CountDown

class Room():
  def __init__(self, key, sio):
    self.key = key
    self.players = defaultdict(Player)
    self.sid_list = []
    self.round = 0
    self.rounds_quantity = 1
    self.is_round_started = False
    self.sio = sio
    self.countdown = CountDown(10, self.sio, 'timer', self.key, self.round_player)


  def start_timer(self):
    if self.countdown.get_started() == False:
      self.countdown.set_started(True)
      self.sio.start_background_task(target=self.countdown.start)

  def set_key(self, key):
    self.key = key
  
  def set_player(self, sid, player):
    self.players[sid] = player
    self.sid_list.append(sid)

    if not self.is_round_started:
      self.rounds_quantity *= 2

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
      del(self.sid_list[self.sid_list.index(sid)])

    if len(self.players) < 2:
      self.countdown.stop()
      self.sio.emit('stopCountDown', room=self.key)

    if not self.is_round_started:
      self.rounds_quantity /= 2

  def get_round_player(self):
    if self.round != None:
      sid = self.sid_list[self.round % len(self.sid_list)]
      return self.players[sid]

  def round_player(self):
    print("aqui")
    player = self.get_round_player()

    self.sio.emit('currentRoundPlayer', to=player.get_sid())
    self.sio.emit(
      'roundPlayer',
      jsons.dumps({"message": " é o jogador da vez", "nickname": player.get_nickname()}),
      room=self.key,
      skip_sid=player.get_sid()
    )

    if self.round < self.rounds_quantity:
      self.round += 1
  