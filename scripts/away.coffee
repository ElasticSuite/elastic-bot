# Prints messages when you talk and you're away

open = require("open-uri")

module.exports = (robot) ->
  robot.hear /who sent this?/i, (msg) ->
    user_id = msg.message.user.id
    url = "https://api.hipchat.com/v1/users/show?user_id=" + user_id + "&auth_token=" + process.env.HUBOT_HIPCHAT_TOKEN
    open url, (err, res) ->
      if !err
        user = res.user
        if user.status == 'away'
          first_name = user.name.split(' ')[0]
          msg.send "Hmmmmm. #{first_name} seems to be away and here at the same moment. That's disturbing...but I'm only a robot. Beep boop"

    