Meteor.subscribe 'ratings'

ERRORS_KEYS = 'ratingsErrors'

Template.ratings.onCreated ->
  Session.set ERRORS_KEYS, {}

Template.ratings.helpers
  errorMessages: ->
    _.values Session.get ERRORS_KEYS

  studentRatings: ->
    return Ratings.find
      subjectId: Session.get 'subjectId',
      sort:
        added: -1

  subject: ->
    return Subjects.findOne _id: Session.get 'subjectId'

  categories: ->
    return Categories.find userId: Meteor.userId()

  studentId: ->
    return Session.get 'studentId'


Template.ratings.events
  'click .addRatingSubmit': ->

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

    Meteor.call 'addStudentRating', studentId, studentLastName, subjectId, subjectName, category, value, description, added
    $('.ratingCategory').val('')
    $('.ratingValue').val('')
    $('.ratingDescription').val('')

  'click .deleteRating': ->
    if confirm 'Are you sure?'
      Meteor.call 'deleteRating', @_id
