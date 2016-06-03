require('../view_spec_helper')
IndexPage = require('../../app/modules/home/views/index_page')

describe 'IndexPage', ->
  beforeEach ->
    @view = new IndexPage()

  it 'shows instructions', ->
    DOM.append @view.render().el
    expect(@view.$el.find('p.instructions').text().trim()).to.eq('Press a button to interact with the BLE device')
