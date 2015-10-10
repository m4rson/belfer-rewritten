Meteor.subscribe 'students'

ERRORS_KEYS = 'studentErrors'
Template.group.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.group.helpers
  errorMessages: ->
    _.values Session.get(ERRORS_KEYS)

  groupStudents: ->
    return Students.find groupId: Session.get 'groupId'

  numberOfStudents: ->
    return Students.find(groupId: @_id).count()


Template.group.events
  'click .goBack': ->
    Router.go 'groups'

  'click .addStudentSubmit': ->
    userId = Meteor.userId()
    groupId = Session.get 'groupId'
    groupName = Session.get 'groupName'
    firstName = $('.studentFName').val()
    lastName = $('.studentLName').val()

    errors = {}

    unless firstName
      errors.firstName = 'First Name field is required'
    unless lastName
      errors.lastName = 'Last Name field is required'

    Session.set ERRORS_KEYS, errors
    return if _.keys(errors).length

    Meteor.call 'addNewStudent', userId, groupId, groupName, firstName, lastName
    $('.studentFName').val('')
    $('.studentLName').val('')

  'click .setStudentId': ->
    Session.set 'studentId', @_id
    Session.set 'studentLastName', @lastName
    Session.set 'subjectId', null

  'click .deleteStudent': ->
    if confirm 'Are you sure?'
      Meteor.call 'removeStudent', @_id
