Marionette  = require 'backbone.marionette'
template    = require '../templates/device_item_view'
DeviceItem  = require '../models/device_item'

class DeviceItemView extends Marionette.ItemView
  template: template
  tagName: 'li'
  model: DeviceItem
  attributes: ->
    'data-device-id' : @model.id

module.exports = DeviceItemView
