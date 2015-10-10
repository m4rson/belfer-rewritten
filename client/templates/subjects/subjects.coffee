Meteor.subscribe 'subjects'

ERRORS_KEYS = 'subjectsErrors'

Template.subjects.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.subjects.helpers
  errorMessages: ->
    _.values Session.get ERRORS_KEYS

  studentSubjects: ->
    return Subjects.find studentId: @_id

Template.subjects.events
  'click .addNewSubjectSubmit': ->
    studentId = Session.get 'studentId'
    name = $('.subjectName').val()
    added = new Date()
    errors = {}

    unless name
      errors.subjectName = 'Subject name field is required'

    Session.set ERRORS_KEYS, errors
    return if _.keys(errors).length

    Meteor.call 'addNewSubject', studentId, name, added
    $('.subjectName').val('')

  'click .getSubjectId': ->
    Session.set 'subjectId', @_id
    Session.set 'subjectName', @name

  'click .deleteSubject': ->
    if confirm 'Are you sure?'
      Meteor.call 'removeSubject', @_id
