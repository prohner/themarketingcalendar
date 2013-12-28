# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	# remoteServerName = "http://www.themarketingcalendar.com"
	# remoteServerName = "http://0.0.0.0:3000"
	$('[rel=tooltip]').tooltip()
	
	popover_func = -> 
		$('.popover-test').popover ({
			html: true,
			title: 'This is a test',
			content: '<b>Hello popover world</b>'
		}).popover('show')
	
	remoteServerName = ""
	eventsSourceUrl = remoteServerName + '/calendar/events.js'
	repeatingEventsSourceUrl = remoteServerName + '/repeating_events.js?id=1'
	
	$('#calendar').fullCalendar {
		editable: true
		header: {
			left: 'prev,next today'
			center: 'title'
			right: 'month,basicWeek,basicDay'
		}
		loading: (bool) ->
			if bool
				$('#loading').show()
			else
				$('#loading').hide()
		timeFormat: 'h:mm t{ - h:mm t} '
		dragOpacity: "0.5"
		eventSources: [
			# {
			# 	url: repeatingEventsSourceUrl
			# 	color: 'green'
			# 	textColor: 'white'
			# 	ignoreTimezone: true
			# 	editable: true
			# 	crossDomain: true
			# 	jsonp: true
			# }
			{
				url: eventsSourceUrl 
				ignoreTimezone: true
				crossDomain: true
				jsonp: true
				error: () ->
					alert "there was an error while fetching events"
			}
		]
		eventRender: (event, element) ->
			$(element).attr "rel", "tooltip"
			$(element).attr "data-original-title", event.description
			
		eventAfterAllRender: () ->
			$('[rel=tooltip]').tooltip()
	}
	
ajaxComplete = (e, xhr, settings) ->
	console.log(xhr.responseText)
	eval(xhr.responseText)
	


$(document).ready(ready)
$(document).on('page:load', ready)