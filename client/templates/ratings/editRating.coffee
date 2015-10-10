ERRORS_KEYS = 'ratingsErrors'

Template.editRating.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.editRating.helpers
  errorMessages: ->
    _.values Session.get ERRORS_KEYS

  categories: ->
    return Categories.find userId: Meteor.userId()

Template.editRating.events
  'click .editRatingSubmit': ->
    studentId = Session.get 'studentId'
    studentLastName = Session.get 'studentLastName'
    subjectId = Session.get 'subjectId'
    subjectName = Session.get 'subjectName'
    category = $('.ratingCategory').val()
    value = $('.ratingValue').val()
    description = $('.ratingDescription').val()
    added = moment().format('DD-MM-YYYY')

    errors = {}

    if Session.get("subjectId") is null
      errors.subject = 'Choose a subject'

    unless category
      errors.categoryName = 'Category field is required'

    unless value
      errors.ratingValue = 'Value field is required'

    Session.set ERRORS_KEYS, errors
    return if _.keys(errors).length

    Meteor.call 'editRating', @_id, studentId, studentLastName, subjectId, subjectName, category, value, description, added
    history.back()

  'click .cancelUpdate': ->
    history.back()
