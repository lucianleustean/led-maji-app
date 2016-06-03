app        = require('../../app')
Marionette = require('backbone.marionette')

HomeApp = app.module('home')
HomeApp.startWithParent = false

class HomeApp.Router extends Marionette.AppRouter
  appRoutes:
    ''           : 'home'
    'bleConnect' : 'bleConnect'

API =
  home: ->
    IndexPage = require('./views/index_page')
    app.mainRegion.show new IndexPage()
  bleConnect: ->
    ConnectPage = require('../ble_connect/views/index_page')
    app.mainRegion.show new ConnectPage()

HomeApp.addInitializer ->
  new HomeApp.Router
    controller: API

module.exports = HomeApp
