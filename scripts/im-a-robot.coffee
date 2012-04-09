# listens for "that's hip" and prints disney hipsters

module.exports = (robot) ->
  robot.hear /.*(Elastic:).*/, (msg) ->
    prob = Math.floor(Math.random() * 5)
    if prob == 0
      msg.send "woof woof i'm a robot pretending to be a dog"
    else
      msg.send "beep boop i'm a robot"