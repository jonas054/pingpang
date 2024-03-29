# Ping Pang

## Starting

Two players:

```console
ruby main.rb
```

One player against a "bot":

```console
ruby main.rb -b
```

## Description
The classic Pong game implemented in Ruby with the Gosu library. See
Installation instructions on [The Gosu wiki](https://github.com/gosu/gosu/wiki)
for setting up Gosu.

## Background
The game was implemented during a vacation in China, so the name comes from the
Chinese word for ping-pong, 乒乓, which is spelled pīng pāng in
[pinyin](https://en.wikipedia.org/wiki/Pinyin).

## Game Play
It's a one or two player game. The left player uses `W` and `S` on
the keyboard to move the paddle, and `D` to serve. The right player uses `Up
Arrow` and `Down Arrow` to move and `Left Arrow` to serve, unless it's one
player mode, in which case the bot moves the right paddle.

## Screenshot

<p align="center">
  <img src="https://raw.githubusercontent.com/jonas054/pingpang/master/pingpang.gif" alt="Ping Pang Screenshot"/>
</p>

## Requirements

Ruby 3.0 or later.
