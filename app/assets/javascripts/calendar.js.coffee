# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
	# remoteServerName = "http://www.themarketingcalendar.com"
	remoteServerName = "http://0.0.0.0:3000";
	eventsSourceUrl = remoteServerName + '/calendar/events.js';
	
	$('#calendar').fullCalendar {
		editable: true
		header: {
			left: 'prev,next today'
			center: 'title'
			right: 'month,agendaWeek,agendaDay'
		}
		loading: (bool) ->
			if bool
				$('#loading').show()
			else
				$('#loading').hide()
		timeFormat: 'h:mm t{ - h:mm t} '
		dragOpacity: "0.5"
		eventSources: [
			{
				url: eventsSourceUrl 
				textColor: 'red'
				ignoreTimezone: true
				crossDomain: true
				jsonp: true
				error: () ->
					alert "there was an error while fetching events"
			}
		]
	}
	
ajaxComplete = (e, xhr, settings) ->
	console.log(xhr.responseText)
	eval(xhr.responseText)
