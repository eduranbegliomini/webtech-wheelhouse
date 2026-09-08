# Wheelhouse - Lab 5

**Student Name:** Elena Durán Begliomini
**Course/Section:** Web Technologies

## Description
This is a Ruby on Rails 8 application for a neighborhood bicycle repair shop called Wheelhouse. It uses a PostgreSQL database and Bootstrap for styling. 

You can view the original project specifications and wireframes in the [docs/ folder](./docs/).

## System Requirements
* Ruby 3.x / 4.x
* Ruby on Rails 8
* Node.js & npm
* **PostgreSQL** (Running on localhost). 
  * **Expected Role:** The application expects a PostgreSQL role that matches your operating system username (or the default `postgres` role) with `CREATEDB` permissions to create the database.

## Setup Instructions

1. Install dependencies:
   bundle install
   npm install

2. Database Setup:
   Ensure PostgreSQL is running, then use this single command to create the database, load the schema, and seed the data:
   bin/rails db:setup

3. Compile CSS and Start the Server:
   bin/dev

4. View the app:
   Open your browser and navigate to http://localhost:3000