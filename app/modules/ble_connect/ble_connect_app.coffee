app        = require('../../app')
Marionette = require('backbone.marionette')

BleConnectApp = app.module('ble_connect')
BleConnectApp.startWithParent = false

class BleConnectApp.Router extends Marionette.AppRouter

module.exports = BleConnectApp
