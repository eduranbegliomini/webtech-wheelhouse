# Wheelhouse - Lab 10

**Student Name:** Elena Durán Begliomini  
**Course/Section:** Web Technologies

## Description
This is a Ruby on Rails 8 application for a neighborhood bicycle repair shop called Wheelhouse. It serves as a full-stack application and provides a JSON API for external clients. 

You can view the original project specifications, wireframes, and API documentation in the [docs/ folder](./docs/).

## System Requirements
- Ruby 3.x / 4.x
- Ruby on Rails 8
- Node.js & npm
- **libvips** (Required by Active Storage for image processing: `brew install vips` on Mac, `sudo apt-get install libvips` on Ubuntu, or install via MSYS2 on Windows).
- **PostgreSQL** (Running on localhost). 
  * **Expected Role:** The application expects a PostgreSQL role that matches your operating system username (or the default `postgres` role) with `CREATEDB` permissions to create the database.

## Setup Instructions

1. **Install dependencies:**
   ```bash
   bundle install
   npm install
   ```

2. **Database Setup:**
   Ensure PostgreSQL is running, then use this single command to create the database, load the schema, and seed the data:
   ```bash
   bin/rails db:setup
   ```

3. **API Token Configuration:**
   Private API routes require an authentication token. Do not use your real production token in development. To set up your local token, run:
   ```bash
   EDITOR="code --wait" bin/rails credentials:edit
   ```
   Add this exact line at the bottom of the file, save, and close it:
   ```yaml
   api_token: "your_local_secret_token"
   ```

4. **Start the Server:**
   The external frontend website expects the API to be running on port 3000. Start the server with:
   ```bash
   bin/dev
   ```
   *(Note: By default, `bin/dev` starts the Rails server on port 3000).*

## API Access & The Frontend Website

The public price list API is consumed and displayed dynamically on the shop's external website. You can view the live site here:
**[https://eduranbegliomini.github.io](https://eduranbegliomini.github.io)**

### Terminal Examples (cURL)
You can test the API directly from your terminal:

**1. Public Route (Price List):**
```bash
curl http://localhost:3000/api/v1/services
```

**2. Private Route (Repairs):**
```bash
curl -H "Authorization: Bearer your_local_secret_token" http://localhost:3000/api/v1/repairs
```