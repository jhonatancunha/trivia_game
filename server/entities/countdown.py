class CountDown():
  
  def __init__(self, time, sio, event, room):
    self.started = False
    self.event = event
    self.counter = time
    self.room = room
    self.sio = sio
    
  def start(self):
    while self.counter >= 0 and self.started == True:
      self.sio.emit(self.event, self.counter, to=self.room)
      self.counter -= 1
      self.sio.sleep(1)

  def stop(self):
    self.started = False
    self.counter = 0

  def get_started(self):
    return self.started

  def set_started(self, started):
    self.started = started