{CompositeDisposable} = require 'atom'

module.exports =

  api_call: (count) ->
    username = require('./user.coffee').username
    password = require('./user.coffee').password
    xhr = new XMLHttpRequest
    xhr.open('POST', 'http://codestats.pythonanywhere.com/' + username + '/api_call/', true)
    postdata = 'count=' + count + '&password=' + password
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
    xhr.setRequestHeader("Content-length", postdata.length)
    xhr.send(postdata)

  update: (keystrokes) ->
      if (keystrokes[0] != '^')
        @count++
        if @count > 10
          @api_call @count
          @count = 0

  initialize: ->
    @count = 0

  activate: () ->
    disposables = new CompositeDisposable

    disposables.add atom.keymaps.onDidFailToMatchBinding ({keystrokes, keyboardEventTarget}) =>
      @update keystrokes
