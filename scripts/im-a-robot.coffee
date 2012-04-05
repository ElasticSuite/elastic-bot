# listens for "that's hip" and prints disney hipsters

module.exports = (robot) ->
  robot.hear /.*(Hubot:).*/, (msg) ->
    msg.send "beep boop i'm a robot"