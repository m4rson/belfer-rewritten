Meteor.methods
  addNewStudent: (userId, groupId, groupName, firstName, lastName)->
    Students.insert
      userId: userId,
      groupId: groupId,
      groupName: groupName,
      firstName: firstName,
      lastName: lastName,
      added: new Date()

  removeStudent: (@_id) ->
    Students.remove @_id
    Ratings.remove studentId: @_id

Meteor.publish 'students', ->
  return Students.find()
