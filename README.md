# ios-weekly-pasta-app

App for generating copypastas in polish using GPT-3 from OpenAI. Swift Vapor demonstration.

Demo for presentation at iOS weekly 19.01.2023

## Components 

[PastaApp/](/PastaApp) - iOS client

[PastaServer/](/PastaServer) - REST API server written in swift vapor, SQLite database for persistence 

## How to Run

`PastaServer` requires OpenAI API token to work. It can be obtained [here](https://beta.openai.com/account/api-keys) - you must have OpenAI account to do so (they offer free trial for new users - 18$ of credits). Once you have it, set `PASTA_OPENAI_TOKEN` env var before running the app (in Xcode: Target > Edit Scheme... > Arguments > Environment Variables).

Then build and run, API will be served at `http://localhost:8889`.

