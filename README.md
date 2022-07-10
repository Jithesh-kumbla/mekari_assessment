# README

This is an API only application.

* Ruby version -> 2.7.1
* Rails version -> 6.1.6

* For authentication and authorization, I have used jwt and rails shipped bcryt to secure the password. Separate 		service class is written to handle jwt encoding and decoding.

* Each endpoint is namescoped as yourDomain.com/api/v1/. Each request should contain headers with Authorization: 		"Bearer token", except for signup.

* For test coverage, I have used rspec. Most of the requests and model spec has the test cases written. You can 		find the test cases in spec/ directory.

* A basic Representer class is used for sending the response back to the client.