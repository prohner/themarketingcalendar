# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('#calendar').fullCalendar {
		editable: true,
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		}
		loading: (bool) ->
			if bool
				$('#loading').show
			else
				$('#loading').hide
		,
		timeFormat: 'h:mm t{ - h:mm t} '
		dragOpacity: "0.5"
	}