# Description
#   omikuji
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_OMIKUJI_INITIAL_DATA
#
# Commands:
#   hubot omikuji [<type>] - display omikuji
#
# Author:
#   kakakikikeke-fork forked from bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.respond /omikuji(\s+(\S+))?(\s+(.+))?$/i, (res) ->
    username = res.message.user.name
    data = JSON.parse(process.env.HUBOT_OMIKUJI_INITIAL_DATA ? '{}')
    data.default = data.default ? ["凶", "吉", "大吉"]
    type = res.match[2] ? 'default'
    if type != 'default'
      idx = data[type].indexOf(username)
      if idx != -1
         delete data[type].splice(idx, 1)
    msg = res.match[4] ? ''
    try
      res.send "#{res.random(data[type])} #{msg}"
    catch e
      if e instanceof TypeError
        res.send "error"
