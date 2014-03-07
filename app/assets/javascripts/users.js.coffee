# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	subscription.setupForm()

subscription =
	setupForm: ->
		# alert "setting up form"
		$('#new_user').submit ->
			$('input[type=submit]').attr('disabled', true)
			# alert "submitting form"
			if $('#card_number').length
				subscription.processCard()
				false
			else
				alert "couldn't find card number"
				true

	processCard: ->
		card =
			number: $('#card_number').val()
			cvc: $('#card_code').val()
			expMonth: $('#card_month').val()
			expYear: $('#card_year').val()
		Stripe.createToken(card, subscription.handleStripeResponse)

	handleStripeResponse: (status, response) ->
		if status == 200
			# alert response.id
			$('#user_stripe_card_token').val(response.id)
			# alert $('#user_stripe_card_token').val()
			$('#new_user')[0].submit()
		else
			alert response.error.message
			$('#stripe_error').text(response.error.message)
			$('input[type=submit]').attr('disabled', false)
			
$(document).ready(ready)
$(document).on('page:load', ready)