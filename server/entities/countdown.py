import jsons
class CountDown():
  
  def __init__(self, time, sio, event, room, callback):
    self.started = False
    self.event = event
    self.counter = time
    self.backup_counter = time
    self.room = room
    self.sio = sio
    self.callback = callback

    
  def start(self):
    self.started = True
    while self.counter >= 0 and self.started == True:
      print("iniciando")
      self.sio.emit(self.event, jsons.dumps({"total_time": self.backup_counter, "time": self.counter}), to=self.room)
      self.counter -= 1
      self.sio.sleep(1)

    print("saiu")
    if self.counter < 0:
      self.stop()
      self.callback()

  def stop(self):
    self.started = False
    self.counter = self.backup_counter

  def get_started(self):
    return self.started

  def set_started(self, started):
    self.started = started
