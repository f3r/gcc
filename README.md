## Heypal Frontend

## Installation

  - Clone
  - Run `bundle install`

## Running

To start the server:

    thin start -p 3005 -s 2

The command above starts to server processes. One for the main app, while the other for the test json fixtures

To stop the server:

    thin stop -p 3005 -s 2

## Testing

To test the models

    rake spec:models

To test the site (see lib/tasks/db.rake)

    rake spec:steak

Do not use rake spec:acceptance since steak by default runs rake db:test:prepare - which we basically don't have since we don't have any ORM loaded on the app.


   



  

    
