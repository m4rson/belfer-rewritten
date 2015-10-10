Template.student.events
  'click .goBack': ->
    history.back()

Template.student.helpers
  studentId: ->
    return Session.get 'studentId'
