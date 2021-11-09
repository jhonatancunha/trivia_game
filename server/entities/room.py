from collections import defaultdict
import jsons
import re

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
    self.answer = ''
    self.answer_mask = ''
    self.theme = ''
    self.hint = ''
    self.wait_players = CountDown(10, self.sio, 'timer', self.key, self.round_player)
    self.wait_word = CountDown(15, self.sio, 'waitWord', self.key, self.round_player)


  def start_timer(self):
    if self.wait_players.get_started() == False:
      self.sio.start_background_task(target=self.wait_players.start)

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
      self.wait_players.stop()
      self.sio.emit('stopCountDown', room=self.key)

    if not self.is_round_started:
      self.rounds_quantity /= 2


  def get_round_player(self):
    sid = self.sid_list[self.round % len(self.sid_list)]
    return self.players[sid]

  def round_player(self):
    if self.round < self.rounds_quantity:
      player = self.get_round_player()

      self.sio.emit('currentRoundPlayer', to=player.get_sid())
      self.sio.emit(
        'roundPlayer',
        jsons.dumps({"message": " %s está elaborando a palavra da rodada..." % player.get_nickname()}),
        room=self.key,
        skip_sid=player.get_sid()
      )

      self.sio.start_background_task(target=self.wait_word.start)

      if self.round < self.rounds_quantity:
        self.round += 1
    
    else:
      self.finish_game()

  def start_round(self):
    self.sio.emit(
      'startRound',
      jsons.dumps({
        "theme": self.theme,
        "answer": self.answer_mask,
        "hint": self.hint,
        "current_round": self.round,
        "n_amount": self.rounds_quantity
      }),
      to=self.key
    )

  def finish_game(self):
    self.sio.emit(
      'finishGame',
      jsons.dumps({"players": self.get_all_players()}), 
      to=self.key
    )

  def set_round_word(self, answer, theme, hint):
    print(answer, theme, hint)
    self.answer = answer.strip()
    self.theme = theme
    self.hint = hint
    self.answer_mask = ''.join([' ' if x == ' ' else '*' for x in self.answer])

    self.wait_word.stop()
    self.start_round()
