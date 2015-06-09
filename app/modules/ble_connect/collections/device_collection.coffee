Backbone = require 'backbone'
model    = require '../models/device_item'

class DeviceCollection extends Backbone.Collection
  model: model

module.exports = DeviceCollection
