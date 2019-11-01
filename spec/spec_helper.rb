# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/' # for rspec
  add_filter '/test/' # for minitest
end
