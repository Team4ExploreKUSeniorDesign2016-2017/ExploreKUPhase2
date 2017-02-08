#= require active_admin/base
#= require active_admin/select2
ready = ->
  $(".polyselect").on "change", ->
    $('.polyform').hide()
    $('#' + $(@).val() + '_poly').show()
    $(".select2-container").css('width', '');

  $('.polyform').first().parent('form').on "submit", (e) ->
    $('.polyform').each (index, element) =>
      $e = $(element)
      if $e.css('display') != 'block'
        $e.remove()

$(document).ready(ready)
$(document).on('page:load', ready)
