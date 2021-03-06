# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

popoverIsShowing = false
is_deleted_event = false
hidden_category_groups = []
snapIsShowing = false
popoverThatIsCurrentlyShowing = null
debugging = true

@toggleSnap = ->
	if snapIsShowing
		snapper.close()
		snapIsShowing = false
	else
		snapper.expand('left')
		snapIsShowing = true
	false

ready = ->
	
	# $('body').on 'click', (e) ->
	# 	removeAnyVisiblePopovers(e)
		
	# remoteServerName = "http://www.themarketingcalendar.com"
	# remoteServerName = "http://0.0.0.0:3000"
	
	remoteServerName = ""
	eventsSourceUrl = remoteServerName + '/calendar/events.js'
	
	if typeof $('#calendar').fullCalendar != 'undefined'
		$('#calendar').fullCalendar {
			editable: true
			header: {
				left: 'prev,next,today'
				center: 'title'
				right: 'month,basicWeek,basicDay'
			}
			weekNumbers: true
			loading: (bool) ->
				if bool
					$('#loading').show()
					$('#reveal-snap-toggle').hide()
				else
					$('#loading').hide()
					$('#reveal-snap-toggle').show()
			timeFormat: 'h:mm t{ - h:mm t} '
			dragOpacity: "0.5"
			eventSources: [
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
				# console.log "Checking '" + event.title + "'" if debugging
				if hidden_category_groups.indexOf(event.category_group_id) >= 0
					# console.log "  Event '" + event.title + "' category is hidden" if debugging
					$(element).hide();
			
			eventAfterRender: (event, element, view) ->
				$(element).attr "id", "event-id-" + event.id
			
			eventClick: (event, jsEvent, view) ->
				if removeAnyVisiblePopovers jsEvent
					return
				
				thisObject = this
				offset = $(this).offset()
				left = jsEvent.pageX
				top = jsEvent.pageY
				console.log "(" + left + ", " + top + ")" if debugging 
			
				# alert event.my_url
				if ! popoverIsShowing
					popoverIsShowing = true
					console.log "popping " + event.title if debugging 
					presentPopover event.my_url, thisObject, event

				else
					popoverIsShowing = false
		}
	
	$('span:contains(today)').parents('td').filter(':first').before('<span id="add-calendar-event" class="expand-panel-btn fc-button fc-button-today fc-state-default fc-corner-left fc-corner-right">&#8853;</span>');
	# $('span:contains(today)').parents('td').filter(':first').before('<span class="fc-button fc-state-default fc-corner-left fc-corner-right no-underline-on-hover"><a href="#" onclick="return toggleSnap();" style="color:#000;a:hover {text-decoration:none;}">&#8596;</a></span>');

		
	$('#add-calendar-event').click (e) ->
		thisObject = this
		if popoverIsShowing 
			popoverIsShowing = false
		else
			popoverIsShowing = true
			presentPopover "/new_event_in_popover", thisObject, { }

	# When this is enabled then clicking on the calendar in the popover dismisses the popover
	# $('body').click (e) ->
	# 	console.log "Clicked body" if debugging
	# 	if popoverIsShowing
	# 		console.log "  Popover is showing" if debugging
	# 		removeAnyVisiblePopovers e
		

removeAnyVisiblePopovers = (clickEvent) ->
	console.log "click 0 " + popoverIsShowing if debugging
	removedAnything = false
	if popoverIsShowing
		console.log "  click 1 " + popoverThatIsCurrentlyShowing if debugging
		if popoverThatIsCurrentlyShowing?
			console.log "    click 2" if debugging
			popContainer = jQuery("bs.popover")
			# alert popContainer
			if $('.popover').has(clickEvent.target).length == 0
				console.log "      click is NOT in popover" if debugging
				$(popoverThatIsCurrentlyShowing).popover('hide')
				popoverThatIsCurrentlyShowing = null
				removedAnything = true
			# else
			# 	console.log "      click is in popover"
	removedAnything
	
	
ajaxComplete = (e, xhr, settings) ->
	console.log(xhr.responseText) if debugging
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
	thisObject.isUnshownObject = true

	is_deleted_event = false
	console.log "presentPopover starting" if debugging
	$.get url, (d) ->
		title = event.title
		adding_new_event = (typeof event.title == "undefined")
		
		if adding_new_event
			title = "New Event"
		$(thisObject).popover({
			title: '<span class="text-info"><strong>' + title + '</strong></span>' + '<button type="button" id="popovercloseid" class="close" onclick="return false;">&times;</button>'
			html: true
			template: '<div class="popover popover-width-control" style="max-width: 1000px!important; width:600px; height:350px;"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
			content: d
			placement: 'auto'
			container: '#calendar'
		})
	
		$(thisObject).on "show.bs.popover", (e) ->
			console.log "popover.on.show " if debugging
			
		$(thisObject).on "shown.bs.popover", (e) ->
			console.log "popover.on.shown " if debugging
			if adding_new_event
				$("#name_of_popover_that_contains_me").val("add-calendar-event")
			else
				console.log "name_of_popover_that_contains_me = " + "event-id-" + event.id if debugging
				$("#name_of_popover_that_contains_me").val("event-id-" + event.id)

		$(thisObject).on "hide.bs.popover", (e) ->
			console.log "popover.on.hide, deleted: " + $("#event_was_deleted").val() + ", typeof=" + typeof($("#event_was_deleted").val()) if debugging
			is_deleted_event = ($("#event_was_deleted").val() == "true")
			console.log "    => is_deleted_event = " + is_deleted_event if debugging
	
		$(thisObject).on "hidden.bs.popover", (e) ->
			console.log "popover.on.hidden" if debugging
			new_json = $("#saved_event_result_as_json").val()
			is_new_event = ($("#saved_event_is_new_event").val() == "true")
			original_repetition_type = $("#original_repetition_type").val()
			
			console.log "    => is_deleted_event = " + is_deleted_event + ", is_new_event = " + is_new_event  if debugging
			
			# alert $("#saved_event_is_new_event").val() + " " + is_new_event
			if is_deleted_event
				$('#calendar').fullCalendar 'removeEvents', [ event._id ]
			else if typeof new_json != "undefined" and new_json.length > 0
				# These variables are coming from event.rb
				json_obj = jQuery.parseJSON new_json
				console.log "rep_type=" + json_obj.repetition_type + ", originally:" + original_repetition_type if debugging
				if json_obj.repetition_type == "weekly" 
					console.log "		REFETCHING EVENTS " + json_obj.repetition_type if debugging
					$('#calendar').fullCalendar 'refetchEvents'
				else if json_obj.repetition_type == "biweekly" 
					console.log "		REFETCHING EVENTS " + json_obj.repetition_type if debugging
					$('#calendar').fullCalendar 'refetchEvents'
				else if is_new_event
					if thisObject.isUnshownObject
						event = { }
						event = massAssignEvent event, json_obj
						$('#calendar').fullCalendar 'renderEvent', event, true
					thisObject.isUnshownObject = false
				else
					event = massAssignEvent event, json_obj
					$('#calendar').fullCalendar 'updateEvent', event
			popoverIsShowing = false
			
		$(thisObject).popover('show')

		popoverThatIsCurrentlyShowing = thisObject


@toggleCalendarFilterCategoryGroup = (categoryGroupId, updateDatabaseToo) ->
	indexOfCategoryGroupId = hidden_category_groups.indexOf(categoryGroupId)
	if indexOfCategoryGroupId  >= 0
		hidden_category_groups.splice indexOfCategoryGroupId , 1
		console.log "Remove " + categoryGroupId if debugging
	else
		hidden_category_groups.push(categoryGroupId)
		console.log "  Add  " + categoryGroupId if debugging
	
	if updateDatabaseToo
		$.ajax {
			url: "/update_hidden_category_group_flag/" + categoryGroupId,
			type: "GET",
			dataType: "JSON" 
		}
	
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