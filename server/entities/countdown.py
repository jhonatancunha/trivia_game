class CountDown():
  
  def __init__(self, time, sio, event, room):
    self.started = False
    self.time = time
    self.event = event
    self.counter = 0
    self.room = room
    self.sio = sio
    
  def start(self):
    self.started = True
    while self.counter <= self.time:
      self.sio.emit(self.event, self.counter, to=self.room)
      self.counter += 1
      self.sio.sleep(1)
    