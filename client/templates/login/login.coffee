ERRORS_KEYS = 'loginErrors'

Template.login.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.login.helpers
  errorMessages: ->
    _.values Session.get(ERRORS_KEYS)

  loginErr: ->
    return Session.get('loginErr')

Template.login.events 'click .loginSubmit': ->

  username = $('.loginUsername').val()
  password = $('.loginPassword').val()
  errors = {}

  unless username
    errors.username = 'Username field is required'

  unless password
    errors.password = 'Password field is required'

  Session.set ERRORS_KEYS, errors
  return if _.keys(errors).length

  Meteor.loginWithPassword username, password, (error)->
    if error
      Session.set('loginErr', error.message)
    else
      Router.go 'groups'
