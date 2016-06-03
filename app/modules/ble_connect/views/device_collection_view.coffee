Marionette      = require('backbone.marionette')
$               = require('jquery')
DeviceItemView  = require('../views/device_item_view')

class DeviceCollectionView extends Marionette.CollectionView
  itemView:  DeviceItemView
  tagName:   'ul'
  className: 'list'

module.exports = DeviceCollectionView
