# Prints messages when you talk and you're away

module.exports = (robot) ->
  robot.hear /who sent this?/i, (msg) ->
    user_id = msg.message.user.id
    url = "https://api.hipchat.com/v1/users/show?user_id=" + user_id + "&auth_token=" + process.env.HUBOT_HIPCHAT_TOKEN
    open url, options, (err, res) ->
        if !err
          msg.send JSON.stringify(res) 

    