# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	# remoteServerName = "http://www.themarketingcalendar.com"
	# remoteServerName = "http://0.0.0.0:3000"
	
	popoverIsShowing = false
	
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

		eventClick: (event, jsEvent, view) ->
			thisObject = this
			offset = $(this).offset()
			left = jsEvent.pageX
			top = jsEvent.pageY
			console.log "(" + left + ", " + top + ")"
			
			# alert event.my_url
			if ! popoverIsShowing
				popoverIsShowing = true
				$.get event.my_url, (d) ->
					$(thisObject).popover({
						title: '<strong>Updating</strong> ' + event.title
						html: true
						template: '<div class="popover popover-width-control" style="max-width: 1000px!important; width:600px;"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
						content: d
						placement: 'top'
						container: 'body'
					})
					.popover('show')
					
					$('edit_event').submit ->
						alert 'doing it' 
					
			else
				popoverIsShowing = false

		eventAfterRender: (event, element, view) ->
			event.element = element # Stored for use in eventClick
			# $(element).tooltip { 
			# 	title: event.description
			# 	html: true 
			# 	placement: 'top'
			# 	container: 'body'
			# }
			
			# $(element).attr "data-ajaxload", event.my_url
			# $(element).popover { 
			# 	title: event.title
			# 	html: true
			# 	content: () ->
			# 		e = $(this)
			# 		$.get event.my_url, (d) ->
			# 			$(this).popover {content: d}
			# 			# e.popover({ content: d })
			# 	'placement': 'top'
			# 	container: 'body'
			# }
			
			# $(element).on 'shown.bs.popover', () ->
			# 	$(this).tooltip('hide')
			# 	# console.log "whatev"
			
		# eventAfterAllRender: () ->
		# 	$('.popover-item').popover(placement: 'auto')
		
	}
	
ajaxComplete = (e, xhr, settings) ->
	console.log(xhr.responseText)
	eval(xhr.responseText)
	

myLittleTest = (me) ->
	po = $(me).popover ({
		title: event.title
		html: true
		content: "content here"
		placement: 'top'
		container: 'body'
	})
	$(me).popover('show')
	false
window.myLittleTest = myLittleTest
	
$('#edit_event').submit ->
	alert 'submitting'
	valuesToSubmit = $(this).serialize()
	$.ajax {
		url: $(this).attr('action')
		data: valuesToSubmit,
		dataType: "JSON"
	} 
	.success (json) -> 
		console.log "success"

	false


$(document).ready(ready)
$(document).on('page:load', ready)