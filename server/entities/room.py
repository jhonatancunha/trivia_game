from collections import defaultdict
import jsons
from random import randint
from rich import inspect

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
    self.amount_of_tips = 0
    self.theme = ''
    self.hint = ''
    self.wait_players = CountDown(10, self.sio, 'timer', self.key, self.round_player)
    self.wait_word = CountDown(15, self.sio, 'waitWord', self.key, self.round_player)
    self.round_timer = CountDown(60, self.sio, 'roundTimer', self.key, self.round_player)
    self.thread_reveal_letter = False

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
    
    self.reset_tips_reveal_letter()

    inspect(self.thread_reveal_letter, methods=True)
    self.sio.start_background_task(target=self.round_timer.start)
    self.thread_reveal_letter = self.sio.start_background_task(target=self.reveal_letter_handler)


  def finish_game(self):
    self.sio.emit(
      'finishGame',
      jsons.dumps({"players": self.get_all_players()}), 
      to=self.key
    )

  def reset_tips_reveal_letter(self):
    if self.thread_reveal_letter != False:
      self.thread_reveal_letter.kill()
    
    self.amount_of_tips = 0
    
    
  def reveal_letter(self):
    letter_index = randint(0, len(self.answer_mask)-1)

    while self.answer_mask[letter_index] != '*':
      letter_index = randint(0, len(self.answer_mask)-1)

    word = list(self.answer_mask)
    word[letter_index] = self.answer[letter_index]
    self.answer_mask = ''.join(word)


  def get_percentage_reveald(self):
    return (self.amount_of_tips * 100) / len(self.answer)


  def reveal_letter_handler(self):
    print('entrou no contador caraio')
    while self.round_timer.get_started() == True and self.get_percentage_reveald() <= 60:
      print('ta revelando as palavra fi')
      self.sio.sleep(15)
      self.reveal_letter()
      self.amount_of_tips += 1
      self.sio.emit('revealLetter', jsons.dumps({"answer_mask": self.answer_mask}))

  def set_round_word(self, answer, theme, hint):
    print(answer, theme, hint)
    self.answer = answer.strip()
    self.theme = theme
    self.hint = hint
    self.answer_mask = ''.join([' ' if x == ' ' else '*' for x in self.answer])

    self.wait_word.stop()
    self.start_round()
