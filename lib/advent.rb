# frozen_string_literal: true

require 'advent/version'
require_relative 'twenty/days/day'
require_relative 'twentyone/days/day'
require 'thor'
require 'pastel'
require 'terminal-table'

module Advent
  class CLI < Thor
    desc 'info', 'get information'
    def info
      pastel = Pastel.new
      puts pastel.green('Advent of Code is an Advent calendar of small programming puzzles.')
      puts pastel.red('This is my first attempt to do them in ruby!')
    end

    # practice with thor
    option :from, required: true
    option :yell, type: :boolean
    desc 'hello NAME', 'say hello to NAME'
    def hello(name)
      output = []
      output << "from: #{options[:from]}" if options[:from]
      output << "Hello #{name}"
      output = output.join("\n")
      puts options[:yell] ? output.upcase : output
    end

    desc 'solve_twenty [DAY]', 'provides the solution for aoc day in 2020 and part entered'
    def solve_twenty(day)
      day = Twenty::Day.new(day.capitalize)
      puts day.solution
    end

    desc 'solve_twentyone [DAY]', 'provides the solution for aoc day in 2021 and part entered'
    def solve_twentyone(day)
      day = TwentyOne::Day.new(day.capitalize)
      puts day.solution
    end

    # adding so I can use them when the output is a
    # grid with certain lit cells (there is always AT LEAST one)
    desc 'colors', 'demo of color options using pastel'
    def colors
      pastel = Pastel.new
      puts pastel.bright_green('Unicorns!')
      puts pastel.magenta('love')
      puts pastel.bright_blue('colors!')
    end

    desc 'table', 'demo of table output'
    def table
      rows = []
      rows << ['One', 1]
      rows << ['Two', 2]
      rows << ['Three', 3]
      table = Terminal::Table.new rows: rows
      puts table
    end
  end
end
