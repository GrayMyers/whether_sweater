# Whether Sweater

__This project is the repo for a submission of [sweather whether project](https://backend.turing.io/module3/projects/sweater_weather).__

## About This Project

Whether Sweater is an API allowing users to plan road trips and access weather forecasts for their planned destination.  It is used as a final assessment in the 3rd module at [Turing School of Software and Design](https://backend.turing.io/module3/).  The 3rd module focuses on building the skills necessary to build professional web applications.

## Local Setup

1. Clone down the repo in the desired directory, by running
``git clone https://github.com/GrayMyers/whether_sweater``
2. Install gems
``bundle install``
3. Create and migrate the database
``rails db:create db:migrate``
4. Get API keys for [OpenWeather](https://openweathermap.org/api) and [MapQuest](https://developer.mapquest.com/documentation/)
5. Add an application.yml file with API keys
```ruby
# config/application.yml
OPENWEATHER_KEY: "[openweather key here]"
MAPQUEST_KEY: "[mapquest key here]"
```
6. Use ``rails s`` to locally run a server

## Test Suite
Both automated and manual testing tools are setup for the app.
* The manual testing suite is available to download as a [postman collection](https://drive.google.com/file/d/1svLREe3gEwvXje1LJ5WXuuOBl8bPCSVB/view?usp=sharing)
* The automated testing suite is included in the app and can be run with `bundle exec rspec` after it has been set up locally.

## Versioning
* Ruby 2.7.0
* Rails 5.2.4.5
