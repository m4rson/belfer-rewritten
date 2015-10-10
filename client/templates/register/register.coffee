ERRORS_KEYS = 'registerErrors'
Template.register.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.register.helpers
  errorMessages: ->
    _.values Session.get(ERRORS_KEYS)

  flashMessage: ->
    Session.get 'flashMessage'


Template.register.events 'click .registerSubmit': ->
  username = $('.registerUsername').val()
  email = $('.registerEmail').val()
  password = $('.registerPassword').val()
  errors = {}

  #username validation
  unless username
    errors.username = 'Username field is required'

  #email validation
  pattern = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  unless email
    errors.email = 'Email field is required'
  else
    errors.email = 'Email is not valid' unless pattern.test(email)

  #password validation
  unless password
    errors.password = 'Password field is required'
  else
    errors.password = 'Password must have at least 6 characters!' if password.length < 6

  Session.set ERRORS_KEYS, errors
  return if _.keys(errors).length
  Meteor.call 'registerNewUser', username, email, password, ->
    Router.go '/'

  Session.set 'flashMessage', 'You have been registered'

  username = $('.registerUsername').val('')
  email = $('.registerEmail').val('')
  password = $('.registerPassword').val('')
