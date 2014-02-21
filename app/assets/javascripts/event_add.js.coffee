jQuery ->
	$("#event_starts_at").datepicker { dateFormat: "yy-mm-dd" }
	$("#event_ends_at").datepicker { dateFormat: "yy-mm-dd" }

	nextButtonClicked()
	
focusOn = (div) ->
	for thisDiv in [ "#event-description", "#starts-at", "#ends-at", "#repetition-type" ]
		if thisDiv == div
			$(thisDiv).css 'background-color', '#FFFF00'
		else
			$(thisDiv).css 'background-color', 'white'

@nextButtonClicked = ->
	if $("#event_description").val().length == 0
		$("#starts-at").hide()
		$("#ends-at").hide()
		$("#repetition-type").hide()
		focusOn("#description")
		$("#event_description").focus()
	else if $("#event_starts_at").val().length == 0
		$("#starts-at").show()
		$("#ends-at").hide()
		$("#repetition-type").hide()
		focusOn("#starts-at")
	else if $("#event_ends_at").val().length == 0
		$("#starts-at").show()
		$("#ends-at").show()
		$("#repetition-type").hide()
		focusOn("#ends-at")
	else
		$("#starts-at").show()
		$("#ends-at").show()
		$("#repetition-type").show()
		focusOn("#repetition-type")

	false
