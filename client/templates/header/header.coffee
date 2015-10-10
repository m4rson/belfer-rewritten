Template.header.events
  'click .logoutButton': ->
    if confirm 'Are you sure?'
      Meteor.logout()
      Router.go '/' 
