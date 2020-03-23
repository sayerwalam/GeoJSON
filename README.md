## This application is built on top of sinatra and exposes 3 geoJson APIs

### Getting Started

`Do a bundle install`

#### Configure config/database.yml to connect to pg server
`database: YOUR_DATABASE_NAME`

`username: YOUR_PG_USERNAME`

`password: YOUR_PG_PASSWORD`


#### Create database and run migrations
`rake db:create && rake db:migrate`


#### Run the application server
`ruby app.rb`


### To Test the application
	
` Open any API testing GUI like postman, Enter in the URL`
   
   ` For POST API`
     `http://localhost:4567/push`
      ` and in the body, select form-data and enter the values`
      ` type = Point
        co-ordinate[0] = 100.5
        co-ordinate[1] = 0.66 `
    
    `For Radius API`
        `http://localhost:4567/radius`
      `and in the params section, enter the params`
      ` co-ordinate[0] = 100.0
        co-ordinate[1] = 0.0 
        radius = 5`

      `For Polygon API`
        `http://localhost:4567/polygon`
      `and in the params section, enter the params`
      ` coordinates[0][0][0] = 100.0
        coordinates[0][0][1] = 0.0 
        coordinates[0][1][0] = 101.0
        coordinates[0][1][1] = 0.0
        coordinates[0][2][0] = 101.0
        coordinates[0][2][1] = 1.0
        coordinates[0][3][0] = 100.0
        coordinates[0][3][1] = 1.0` 

### To Lint the application
      `Just Go to the root directory and type rubocop`

