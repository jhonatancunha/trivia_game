
class Player():
  def __init__(self, sid, nickname, score=0, room='123'):
    self.sid = sid
    self.nickname = nickname
    self.score = score
    self.room = room
    self.correct_asnwer = False
    
  
  def set_sid(self, sid):
    self.sid = sid
  
  def set_nickname(self, nickname):
    self.nickname = nickname
  
  def set_score(self, score):
    self.score = score
  
  def set_room(self, room):
    self.room = room
    
  def set_correct_asnwer(self, value):
    self.correct_asnwer = value
    
  def get_sid(self):
    return self.sid
  
  def get_nickname(self):
    return self.nickname
  
  def get_score(self):
    return self.score
  
  def get_room(self):
    return self.room
  
  def right_answer(self, time, point_of_question):
    self.set_correct_asnwer(True)
    new_score = self.score + point_of_question * time
    self.set_score(new_score)
    
    return new_score
    
  def right_answer_player_of_round(self, score):
        self.set_score(self.score + score)

