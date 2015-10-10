Meteor.methods
  addNewCategory: (userId, name) ->
    Categories.insert
      userId: userId,
      name: name

  deleteCategory: (@_id) ->
    Categories.remove @_id

Meteor.publish 'categories', ->
  return Categories.find()
