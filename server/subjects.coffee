Meteor.methods
  addNewSubject: (studentId, name, added)->
    Subjects.insert
      studentId: studentId,
      name: name,
      added: added

  removeSubject: (@_id) ->
    Subjects.remove @_id
    Ratings.remove subjectId: @_id

Meteor.publish 'subjects', ->
  return Subjects.find()
