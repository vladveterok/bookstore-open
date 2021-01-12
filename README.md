# README

[![vladveterok](https://circleci.com/gh/vladveterok/bookstore-open.svg?style=shield)](https://circleci.com/gh/vladveterok/bookstore-open)

Hey! Meet Bookstore! It's, well, it's a simple bookstore I've made while attending the RubyGarage academy. I believe there's everything a small and cozy country bookstore would need to sell books, except, maybe, for the payment system (and cats).

> Check Bookstore on Heroku: https://whispering-tundra-66089.herokuapp.com

### Technicalities:
---
* Ruby version: 2.7.1
* Database version: Postgresql 12
* CI: CircleCi

### Technologies:
---
Check [Gemfile](https://github.com/vladveterok/bookstore-open/blob/main/Gemfile) to see all the technologies used.

### What was done:
---
* Initialize Project (Setup Rails, setup gems, setup linters, setup environment and environment variables if needed);
* Setup assets and static pages markup;
* CircleCI configuration;
* Setup Home page without images and bestsellers;
* Catalog -- Show books / Show categories with books count / Filter/Sort books / Paginate books 
* Book page -- Info about a book / Read more link / Back to results link
* Log in page / Sign up page / Forgot password page
* Dynamic headers/footers for all pages for guest/user
* Log in and Sign up logic via Devise with dynamic error setting(Simple Form)
* Registration via Omniauth-Facebook
* Send notification to user about registration/forgot password 
* User profile page -- Personal information form / Delete account form / Addresses form
* Admin panel
* Reviews on Book page + Admin page logic for accepting reviews
* Images uploading/displaying for all imagable models and pages
* Storing all the product images on S3
* Cart logic + Coupon logic
* Authentication without password during the Checkout
* Checkout logic + State Machine that switches status of the Checkout
* Bestsellers SQL query
* My orders page with all the orders user made
* Validations
* Some silly JavaScript here and there to support front end logic
* Tests (unit and feature). Coverage: about 97%
* Deployment on Heroku

### What was not done:
---
* CSS -- was provided by the academy
* Payment
* Static pages were provided but redone eventually
