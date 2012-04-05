# Github issue link looks for #nnn and links to that issue for your default repo. Eg. "Hey guys check out #273"
# Requires vars HUBOT_GITHUB_REPO, and HUBOT_GITHUB_TOKEN to be set.
#
# Listens for #nnn and links to the issue for your default repo on github

open = require("open-uri")

module.exports = (robot) ->
  valid_projects = ['skillet', 'scramble', 'oatmeal']

  robot.hear /((.*?([a-zA-Z]+)\s*)|.*)(#(\d+)).*/, (msg) ->
    issue_number = msg.match[4].replace /#/, ""
    if isNaN(issue_number)
      return

    project = msg.match[3]
    if project
      project = project.toLowerCase()
      if valid_projects.indexOf(project) == -1
        project = null

    bot_github_org = process.env.HUBOT_GITHUB_ORG
    bot_github_repos = process.env.HUBOT_GITHUB_REPOS.split(',')
    oauth_token = process.env.HUBOT_GITHUB_TOKEN
    issue_title = ""

    urls = []
    bot_github_repos.forEach (repo) ->
      if project && repo != project
        return

      urls.push("https://api.github.com/repos/#{bot_github_org}/#{repo}/issues/#{issue_number}")

    results = []

    done = () ->
      return if results.length == 0
      msg.send results.join("\n")

    completed = 0

    options = {
      headers: {
        Authorization: "token #{oauth_token}",
        Accept: "application/json"
      }
    }

    urls.forEach (url) ->
      open url, options, (err, res) ->
        completed++

        if !err
          issue_title = res.title

          regex = new RegExp("(skillet|scramble|oatmeal)", 'i')
          parts = regex.exec res.html_url
          response_project = parts[0]

          results.push("[#{response_project}] Issue #{issue_number}: #{issue_title} #{res.html_url}")

        done() if completed == urls.length