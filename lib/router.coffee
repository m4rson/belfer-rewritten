Router.configure layoutTemplate: 'application'
Router.route '/', ->
  @render 'home'
Router.route 'home', ->
  @render 'home'

Router.route 'about'
Router.route 'contact'
Router.route 'register'
Router.route 'login'
Router.route 'logout', ->
  if confirm 'Are you sure?'
    Meteor.logout()
    Router.go '/'
    

Router.route 'categories', ->
  if Meteor.userId()
    @render 'categories'
  else
    Router.go 'login'


Router.route 'groups', ->
  if Meteor.userId()
    @render 'groups'
  else
    Router.go 'login'


Router.route 'groups/:name', (->
  if Meteor.userId()
    @render 'group',
      data: ->
        Groups.findOne name: @params.name
  else
    Router.go 'login'
),
  name: 'group.show'


Router.route 'groups/:groupName/:lastName', (->
  if Meteor.userId()
    groupName = @params.name
    lastName = @params.lastName
    @render 'student',
      data: ->
        Students.findOne groupName: @params.groupName, lastName: @params.lastName
  else
    Router.go 'login'

),
  name: 'student.show'


Router.route '/:subjectName/:_id', (->
  if Meteor.userId()
    groupName = @params.name
    studentLastName = @params.lastName
    subjectName = @params.subjectName
    id = @params._id
    @render 'editRating',
      data: ->
        Ratings.findOne  subjectName: @params.subjectName, _id: @params._id
  else
    Router.go 'login'

),
  name: 'rating.edit'
