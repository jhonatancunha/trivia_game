from collections import defaultdict

class Room():
  def __init__(self, key):
    self.key = key
    self.players = defaultdict(dict)
  
  
  def set_key(self, key):
    self.key = key
  
  def set_player(self, sid, player):
    self.players[sid] = player
  
  
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