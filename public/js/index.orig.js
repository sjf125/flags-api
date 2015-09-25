//jQuery.ajax
$(function() {
  'use strict';
  var gameWatcher;
  var sa = '//localhost:3000';
//  var sa = 'http://ttt.wdibos.com';
//  var sa = 'http://10.13.108.54:3000';

  $('#register').on('click', function(e) {
    $.ajax(sa + '/users', {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({
        credentials: {
          email: $('#email').val(),
          password: $('#password').val(),
          password_confirmation: $('#password').val()
        }
      }),
      dataType: 'json',
      method: 'POST'
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('registration failed');
    });
  });

  $('#login').on('click', function(e) {
    $.ajax(sa + '/login', {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({
        credentials: {
          email: $('#email').val(),
          password: $('#password').val()
        }
      }),
      dataType: 'json',
      method: 'POST'
    }).done(function(data, textStatus, jqxhr){
      $('#token').val(data.token);
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('login failed');
    });
  });

  $('#list').on('click', function(e) {
    $.ajax(sa + '/users', {
      dataType: 'json',
      method: 'GET',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('list failed');
    });
  });

$('#create').on('click', function(e) {
    $.ajax(sa + '/games', {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({}),
      dataType: 'json',
      method: 'POST',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('create failed');
    });
  });

  $('#show').on('click', function(e) {
    $.ajax(sa + '/games/' + $('#id').val(), {
      dataType: 'json',
      method: 'GET',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('show failed');
    });
  });

$('#join').on('click', function(e) {
    $.ajax(sa + '/games/' + $('#id').val(), {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({}),
      dataType: 'json',
      method: 'PATCH',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('join failed');
    });
  });

$('#move').on('click', function(e) {
    $.ajax(sa + '/games/' + $('#id').val(), {
      contentType: 'application/json',
      processData: false,
      data: JSON.stringify({
        game: {
          cell: {
            index: +$('#index').val(),
            value: $('#value').val()
          }
        }
      }),
      dataType: 'json',
      method: 'PATCH',
      headers: {
        Authorization: 'Token token=' + $('#token').val()
      }
    }).done(function(data, textStatus, jqxhr){
      $('#result').val(JSON.stringify(data));
    }).fail(function(jqxhr, textStatus, errorThrown){
      $('#result').val('move failed');
    });
  });

  $('#watch').on('click', function(){
    gameWatcher = resourceWatcher(sa + '/games/' + $('#id').val() + '/watch', {
      Authorization: 'Token token=' + $('#token').val()
    });
    gameWatcher.on('change', function(data){
      var parsedData = JSON.parse(data);
      // heroku routers report this as a 503
      // if (data.timeout) { //not an error
      // gameWatcher.close();
      // return console.warn(data.timeout);
      // }
      var gameData = parsedData.game;
      var cell = gameData.cell;
      $('#index').val(cell.index);
      $('#value').val(cell.value);
    });
    gameWatcher.on('error', function(e){
      console.error('an error has occured witht the stream', e);
    });
  });

});
