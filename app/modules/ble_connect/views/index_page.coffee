ApplicationPage       = require('../../../views/application_page')
Backbone              = require('backbone')
Backbone.LocalStorage = require('backbone.localstorage')
DeviceCollection      = require('../collections/device_collection')
DeviceCollectionView  = require('../views/device_collection_view')
DeviceItem            = require('../models/device_item')
DeviceItemView        = require('../views/device_item_view')
template              = require('../templates/index')

class ConnectPage extends ApplicationPage
  template: template

  regions:
    connectedList: '#connected ul'
    availableList: '#available'

  events: ->
    'click #available li' : 'connectDevice'

  initialize: ->
    @availableDevices = new DeviceCollection()

  onRender: ->
    @availableDevicesView = new DeviceCollectionView({ collection: @availableDevices })
    @availableList.show @availableDevicesView

  onShow: ->
    ble.isEnabled(@scanForDevices, pleaseEnableBle)

  scanForDevices: =>
    if (localStorage.getItem('bleDevice') is null)
      @bleSearch()
    else
      device = JSON.parse(localStorage.bleDevice)
      ble.isConnected(device['id'], @showConnectedDevice.bind(this, device), @bleSearch)

  scanSuccess: (device) =>
    deviceItem = new DeviceItem()
    deviceItem.set(id: device.id, name: device.name)
    @availableDevices.add deviceItem

  showConnectedDevice: (device) ->
    connectedDeviceItem = new DeviceItem()
    connectedDeviceItem.set(id: device.id, name: device.name)

    @availableDevices.remove connectedDeviceItem

    connectedDeviceView = new DeviceItemView({ model: connectedDeviceItem, className: 'connected' })
    @connectedList.show connectedDeviceView

  bleSearch: =>
    ble.scan([], 5, @scanSuccess, scanFailure)

  connectDevice: (e) ->
    deviceId = e.target.dataset.deviceId
    ble.connect(deviceId, @onConnect, connectionFailure)

  onConnect: (device) =>
    localStorage.clear()
    localStorage.setItem('bleDevice', JSON.stringify(device))
    @showConnectedDevice(device)

  pleaseEnableBle = (message) ->
    alert 'Please enable your Bluetooth ..'

  scanFailure = (message) ->
    alert 'scanFailure: ' + message

  connectionFailure = (message) ->
    alert 'connectionFailure: ' + message
    localStorage.clear()

module.exports = ConnectPage
