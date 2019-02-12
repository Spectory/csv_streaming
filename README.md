### Overview

The purpose of this app is to demonstrate how CSV (or any other file, for that matter) can be sent to browser (to download) in stream. We use Rails and Angular here but the logic is more or less the same for any other frameworks.

#### Why streaming?

Sometimes generating a file takes too long, and long server calls aren't always handled well by the browser or the platform (i.e. Heroku timeouts any requests that take longer than 30 seconds).

Streaming the file contents after sending the initial response to the browser solves it.

#### The magic

The magic happens in two places:

1. `client/src/app/app.component.ts` — the download function makes a synchronous call to the server. It generates a form dinamically for that purpose.
2. `app/controllers/export_controller.rb` — the server part.

The server part is borrowed from [this Bernardo Farah's article](https://www.bernardo.me/blog/2017/06/28/streaming-csv-with-rails/).

### How to run the app

#### Build the environment:

```
bundle install
cd client && npm install
```

#### Build the client app:

```
cd client
npm run build
cd ..
rm public/main*
rm public/polyfills*
rm public/styles*
rm public/inline*
cp -rf client/dist/* public/
```

#### Run the server:

```
rails s
```

Go to localhost:3000 and click on the red button.