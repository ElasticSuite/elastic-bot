# Prints messages when you talk and you're away

module.exports = (robot) ->
  robot.hear /who sent this?/i, (msg) ->
    msg.send JSON.stringify(msg.message.user)