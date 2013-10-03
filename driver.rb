require_relative 'app/models/representative'
require 'active_record'

joe = Representative.create(firstname: "GREATEST", lastname: "EVER", gender: "M", webform: "drake@gmail.com")
p joe.name
joe.save
