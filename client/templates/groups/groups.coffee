Meteor.subscribe 'groups'

ERRORS_KEYS = 'groupsErrors'
Template.groups.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.groups.helpers
  errorMessages: ->
    _.values Session.get(ERRORS_KEYS)

  currentUserGroups: ->
    return Groups.find userId: Meteor.userId()

  numberOfStudents: ->
    return Students.find(groupId: @_id).count()

Template.groups.events
  'click .newGroupSubmit': ->
    name = $('.groupName').val()

    errors = {}
    unless name
      errors.groupName = 'Group name field is required'

    Session.set ERRORS_KEYS, errors
    return if _.keys(errors).length

    Meteor.call 'newGroup', name


    $('.groupName').val('')

  'click .groupNameLink': ->
    Session.set 'groupId', @._id
    Session.set 'groupName', @name

  'click .deleteGroup': ->
    if confirm 'Are you sure?'
      Meteor.call 'deleteGroup', @_id
