Meteor.methods
  addStudentRating: (studentId, studentLastName, subjectId, subjectName, category, value, description, added) ->
    Ratings.insert
      studentId: studentId,
      studentLastName: studentLastName,
      subjectId: subjectId,
      subjectName: subjectName,
      category: category,
      value: value,
      description: description
      added: added

  editRating: (@_id, studentId, studentLastName, subjectId, subjectName, category, value, description, added) ->
    Ratings.update @_id,
      studentId: studentId,
      studentLastName: studentLastName,
      subjectId: subjectId,
      subjectName: subjectName,
      category: category,
      value: value,
      description: description
      added: added

  deleteRating: (@_id) ->
    Ratings.remove @_id

Meteor.publish 'ratings', ->
  return Ratings.find {},
    sort:
      added: -1
