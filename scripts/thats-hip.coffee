# listens for "that's hip" and prints disney hipsters

module.exports = (robot) ->
  robot.hear /.*(that'?s (\w+ +)?hip).*/, (msg) ->
    imageMe msg, "\"hipster\"", (url) ->
      msg.send url

imageMe = (msg, query, cb) ->
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData.results
      if images.length > 0
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"