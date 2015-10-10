Meteor.methods
  newGroup: (name) ->
    Groups.insert
      userId: Meteor.userId(),
      name: name,
      added: new Date()

  deleteGroup: (@_id) ->
    Groups.remove @_id
    Students.remove groupId: @_id

Meteor.publish 'groups', ->
  return Groups.find()
