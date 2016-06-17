App.analytics = App.cable.subscriptions.create "AnalyticsChannel",


  connected: ->
      loadAnalytics();

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
      loadAnalytics();
      $('#alert-placeholder').append '<div id="alertdiv" class="alert alert-success"><span>New data ' + data.product.name + '</span></div>'
      setTimeout (->
        $('#alertdiv').fadeOut()
        return
      ), 7000



@loadAnalytics = () =>
  client = new Keen(
    projectId: '575410e7bcb79c09cc723cd2'
    readKey: 'b7e4d1763d784bdddf2ba7f20201ddc1f1727e0bcfcc7eee31a8671acd20e8b0b90883ba11f16066af6f9560a2c21f97884493a1988bb1612c11c9c2b09610e8e25e0f0d34e95ffafd16d793301a052daa13a77c4ee46ac2a00db68b6c0f0781')
  Keen.ready ->
    query1 = new Keen.Query("sum", {
      eventCollection: "product",
      interval: "daily",
      targetProperty: "id",
      timeframe: "this_14_days",
      timezone: "UTC"
    });


    query2 = new (Keen.Query)('count_unique',
      eventCollection: 'product'
      groupBy: [ 'name' ]
      targetProperty: 'favorites'
      timeframe: 'this_14_days'
      timezone: 'UTC')

    client.draw query1, document.getElementById('chart-wrapper'), {}
    client.draw query2, document.getElementById('pie-wrapper'), {}
