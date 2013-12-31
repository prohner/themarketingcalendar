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
		ignoreTimezone: false
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
				console.log "popping " + event.title
				$.get event.my_url, (d) ->
					popover = $(thisObject).popover({
						title: '<span class="text-info"><strong>' + event.title + '</strong></span>' + '<button type="button" id="close" class="close" onclick="$(\'#example\').popover(\'hide\');">&times;</button>'
						html: true
						template: '<div class="popover popover-width-control" style="max-width: 1000px!important; width:600px;"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
						content: d
						placement: 'top'
						container: 'body'
					})
					
					popover.on "hidden", (e) ->
						new_json = $("#saved_event_result_as_json").val()
						if new_json.length > 0
							# These variables are coming from event.rb
							json_obj = jQuery.parseJSON new_json
							# event.id = json_obj.id
							event.title = json_obj.title
							event.color = json_obj.color
							event.textColor = json_obj.textColor
							event.start = json_obj.start
							event.end = json_obj.end
							event.allDay = json_obj.allDay
							event.recurring = json_obj.recurring
							event.location = json_obj.location
							event.notes = json_obj.notes
							event.url = json_obj.url
							# event.my_url = json_obj.my_url  ## causes second display of popover to get wonked up
							$('#calendar').fullCalendar('updateEvent', event);
							popoverIsShowing = false
					popover.popover('show')

			else
				popoverIsShowing = false
			# 	event.title = "C new title after save"
			# 	$('#calendar').fullCalendar('updateEvent', event);

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
	

# myLittleTest = (me) ->
# 	po = $(me).popover ({
# 		title: event.title
# 		html: true
# 		content: "content here"
# 		placement: 'top'
# 		container: 'body'
# 	})
# 	$(me).popover('show')
# 	false
# window.myLittleTest = myLittleTest
# 	
# 
# $('body').on('click',  (e) ->
# 	$('[data-toggle="popover"]').each( () ->
# 			if !$(this).is(e.target)
# 				if $(this).has(e.target).length == 0 
# 					if $('.popover').has(e.target).length == 0
# 						$(this).popover('hide')
# 		)
# 	)
#         
#     
# 
# $('body').on('click', function (e) {
#     $('[data-toggle="popover"]').each(function () {
#         if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
#             $(this).popover('hide');
#         }
#     });
# });

$(document).ready(ready)
$(document).on('page:load', ready)