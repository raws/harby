$:.unshift File.dirname(__FILE__)

require "polyglot"
require "treetop"

require "harby/concerns/delegation"
require "harby/ext/compiled_parser"
require "harby/ext/syntax_node"

require "harby/grammar/command"
require "harby/grammar/list"
require "harby/grammar/numeric"
require "harby/grammar/regex"
require "harby/grammar/string"
require "harby/grammar/arguments"

require "harby/parser"
