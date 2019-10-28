# Elixir SDET Exercise Notes
I installed and set this all up on my Ubuntu 18.04 machine. It was quite a challenge to find the right commands, but in the first hour I got mostly everything configured for the base example .exs test.

## Prerequisites
For Linux, I had to download the latest Linux Chromedriver and replace the one saved in this project. I've never run Chromedriver manually like this before but it wasn't that bad. Make sure to `chmod +x chromedriver` in order to make it executable. Then run `./chromedriver` in terminal. I prefer to run this in a linux `screen` session just in case my terminal crashes or I close it by accident.

IDE used for this project: Atom.io

Also my first time using Atom. Took about 30 minutes to get the right plugins installed for Elixir language support. Could have used vim but I wanted to see how everything would look visually.

Install erlang and elixir:

`wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb`

`sudo apt update`

`sudo apt install -y esl-erlang elixir`


## Setup
`cd` to the project root and run `mix deps.get`

To run tests: `mix test`

For some reason, even though I thought I had installed all dependencies, the first time I ran the `mix test` command it told me to install rebar3. Will ask about this in the interview as I'm not entirely sure how `mix deps.get` missed that. A reinstall of dependencies did not need to reinstall rebar3.

## Facebook Test Examples
The handful of tests I have in this project use some of Facebook's "helpful" documentation.
https://www.facebook.com/help/448505685205813
https://www.facebook.com/help/112146705538576

I managed to get Screenshots on failure, which are saved to the screenshots directory.
