# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

popoverIsShowing = false
is_deleted_event = false
hidden_categories = []

ready = ->
	# remoteServerName = "http://www.themarketingcalendar.com"
	# remoteServerName = "http://0.0.0.0:3000"
	
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
		weekNumbers: true
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
			if hidden_categories.indexOf(event.category_id) >= 0
				console.log "Event's category is hidden"
				$(element).hide();
			
		eventAfterRender: (event, element, view) ->
			$(element).attr "id", "event-id-" + event.id
			
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
				presentPopover event.my_url, thisObject, event

			else
				popoverIsShowing = false
	}
	
	$('span:contains(today)').parents('td').filter(':first').after('<span class="fc-header-space"></span><span id="add-calendar-event" class="fc-button fc-button-today fc-state-default fc-corner-left fc-corner-right">Add Event</span>');
	$('#add-calendar-event').click (e) ->
		thisObject = this
		if popoverIsShowing 
			popoverIsShowing = false
		else
			popoverIsShowing = true
			presentPopover "/new_event_in_popover", thisObject, { }
	
	
ajaxComplete = (e, xhr, settings) ->
	console.log(xhr.responseText)
	eval(xhr.responseText)
	
massAssignEvent = (event, json_obj) ->
	event.id = json_obj.id
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
	event.my_url = json_obj.my_url
	event

presentPopover = (url, sourceObject, event) ->
	thisObject = sourceObject
	is_deleted_event = false
	console.log "presentPopover starting"
	$.get url, (d) ->
		title = event.title
		adding_new_event = (typeof event.title == "undefined")
		
		if adding_new_event
			title = "New Event"
		$(thisObject).popover({
			title: '<span class="text-info"><strong>' + title + '</strong></span>' + '<button type="button" id="popovercloseid" class="close" onclick="return false;">&times;</button>'
			html: true
			template: '<div class="popover popover-width-control" style="max-width: 1000px!important; width:600px; height:400px;"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
			content: d
			placement: 'bottom'
			container: 'body'
		})
	
		$(thisObject).on "show", (e) ->
			console.log "popover.on.show "
			
		$(thisObject).on "shown", (e) ->
			console.log "popover.on.shown "
			if adding_new_event
				$("#name_of_popover_that_contains_me").val("add-calendar-event")
			else
				$("#name_of_popover_that_contains_me").val("event-id-" + event.id)

		$(thisObject).on "hide", (e) ->
			console.log "popover.on.hide, deleted: " + $("#event_was_deleted").val() + ", typeof=" + typeof($("#event_was_deleted").val())
			is_deleted_event = ($("#event_was_deleted").val() == "true")
			console.log "    => is_deleted_event = " + is_deleted_event
	
		$(thisObject).on "hidden", (e) ->
			console.log "popover.on.hidden"
			new_json = $("#saved_event_result_as_json").val()
			is_new_event = ($("#saved_event_is_new_event").val() == "true")
			console.log "    => is_deleted_event = " + is_deleted_event + ", is_new_event = " + is_new_event 
			
			# alert $("#saved_event_is_new_event").val() + " " + is_new_event
			if is_deleted_event
				$('#calendar').fullCalendar 'removeEvents', [ event._id ]
			else if typeof new_json != "undefined" and new_json.length > 0
				# These variables are coming from event.rb
				json_obj = jQuery.parseJSON new_json
				if is_new_event
					event = { }
					event = massAssignEvent event, json_obj
					$('#calendar').fullCalendar 'renderEvent', event, true
				else
					event = massAssignEvent event, json_obj
					$('#calendar').fullCalendar 'updateEvent', event
			popoverIsShowing = false
			
		console.log "showing popover"
		$(thisObject).popover('show')


@toggleCalendarFilterCategory = (categoryId) ->
	indexOfCategoryId = hidden_categories.indexOf(categoryId)
	if indexOfCategoryId >= 0
		hidden_categories.splice indexOfCategoryId, 1
		console.log "Remove " + categoryId
	else
		hidden_categories.push(categoryId)
		console.log "  Add  " + categoryId
	$('#calendar').fullCalendar 'rerenderEvents'
	
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