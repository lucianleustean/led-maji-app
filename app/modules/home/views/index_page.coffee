ApplicationPage = require('../../../views/application_page')
template        = require('../templates/index')
$               = require('jquery')
bus             = require('maji').bus

class IndexPage extends ApplicationPage
  template: template

  ## this data is specific for the BLE device I use
  bleShield =
    service:        'D3E60000-8F36-40D6-B2D5-C5D9F5E81869'
    characteristic: 'D3E60005-8F36-40D6-B2D5-C5D9F5E81869'

  initialize: ->
    if (localStorage.getItem('bleDevice') isnt null)
      @device = JSON.parse(localStorage.bleDevice)

  events:
    'click': (e) ->
      e.preventDefault()
      target = $(e.target)

      @navigate(target.attr('href'), transition: target.data('transition'))

    'click #red'   : 'redLed'
    'click #blue'  : 'blueLed'
    'click #green' : 'greenLed'

  redLed: ->
    data = stringToBytes('red')
    @writeToDevice(data)

  blueLed: ->
    data = stringToBytes('blue')
    @writeToDevice(data)

  greenLed: ->
    data = stringToBytes('green')
    @writeToDevice(data)

  writeToDevice: (data) ->
    ble.write(@device['id'], bleShield.service, bleShield.characteristic, data, success, failure)

  success = ->
    console.log 'Request sent successfully'

  failure = (e) ->
    alert 'Att: ' + e

  stringToBytes = (string) ->
    array = new Uint8Array(string.length)
    i = 0
    l = string.length
    while i < l
      array[i] = string.charCodeAt(i)
      i++
    array.buffer

module.exports = IndexPage
