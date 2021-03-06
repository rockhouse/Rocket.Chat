Template.body.onRendered ->
	dataLayerComputation = Tracker.autorun ->
		w = window
		d = document
		s = 'script'
		l = 'dataLayer'
		i = RocketChat.settings.get 'API_Analytics'
		if Match.test(i, String) and i.trim() isnt ''
			do (w,d,s,l,i) ->
				w[l] = w[l] || []
				w[l].push {'gtm.start': new Date().getTime(), event:'gtm.js'}
				f = d.getElementsByTagName(s)[0]
				j = d.createElement(s)
				dl = if l isnt 'dataLayer' then '&l=' + l else ''
				j.async = true
				j.src = '//www.googletagmanager.com/gtm.js?id=' + i + dl
				f.parentNode.insertBefore j, f
				dataLayerComputation.stop()


Template.main.helpers
	logged: ->
		return Meteor.userId()?

	subsReady: ->
		return not Meteor.userId()? or (FlowRouter.subsReady('userData', 'activeUsers'))

	hasUsername: ->
		return Meteor.userId()? and Meteor.user().username?

	hasAvatar: ->
		return Meteor.userId()? and Meteor.user().avatarOrigin?

	flexOpened: ->
		console.log 'layout.helpers flexOpened' if window.rocketDebug
		return 'flex-opened' if Session.equals('flexOpened', true)

	flexOpenedRTC1: ->
		console.log 'layout.helpers flexOpenedRTC1' if window.rocketDebug
		return 'layout1' if Session.equals('rtcLayoutmode', 1)

	flexOpenedRTC2: ->
		console.log 'layout.helpers flexOpenedRTC2' if window.rocketDebug
		return 'layout2' if (Session.get('rtcLayoutmode') > 1)


Template.main.onRendered ->
	$('html').addClass("noscroll").removeClass "scroll"

	# RTL Support - Need config option on the UI
	if isRtl localStorage.getItem "userLanguage"
		$('html').addClass "rtl"
