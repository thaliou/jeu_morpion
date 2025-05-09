require 'bundler'
Bundler.require
$:.unshift File.expand_path("./../lib/app", __FILE__)
require 'board_case'
require 'board'
require 'player'
require 'show'
require 'game'
require 'application'

# Lancement du jeu
Application.new.perform
