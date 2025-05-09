require 'bundler'
Bundler.require
$:.unshift File.expand_path("./../lib/app", __FILE__)
require 'board_caseV2'
require 'boardV2'
require 'playerV2'
require 'showV2'
require 'gameV2'
require 'applicationV2'
require 'stringer'

# Lancement du jeu
Application.new.run