# Gives elastic-bot character

module.exports = (robot) ->
  robot.hear /.*(Elastic:).*/, (msg) ->
    prob = Math.floor(Math.random() * 6)
    if prob == 0
      msg.send "woof woof i'm a robot pretending to be a dog"
    else if prob == 1
      msg.send "click click i'm a robot pretending to be a sysadmin"  
    else
      msg.send "beep boop i'm a robot"