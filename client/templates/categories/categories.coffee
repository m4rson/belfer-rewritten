Meteor.subscribe 'categories'
ERRORS_KEYS = 'ratingsErrors'

Template.categories.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.categories.helpers
  errorMessages: ->
    _.values Session.get(ERRORS_KEYS)

  userCategories: ->
    return Categories.find userId: Meteor.userId()

  ratings: ->
    return Ratings.find userId: Session.get

Template.categories.events
  'click .newCategorySubmit': ->
    name = $('.categoryName').val()
    userId = Meteor.userId()
    errors = {}

    unless name
      errors.categoryName = 'Category name field is required'

    Session.set ERRORS_KEYS, errors
    return if _.keys(errors).length

    Meteor.call 'addNewCategory', userId, name
    $('.categoryName').val('')

  'click .deleteCategory': ->
    if confirm 'Are you sure?'        
      Meteor.call 'deleteCategory', @_id
