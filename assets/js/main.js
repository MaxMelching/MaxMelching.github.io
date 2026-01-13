/*
	Spectral by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

(function($) {

	var	$window = $(window),
		$body = $('body'),
		$wrapper = $('#page-wrapper'),
		$banner = $('#banner'),
		$header = $('#header');

	// Breakpoints.
		breakpoints({
			xlarge:   [ '1281px',  '1680px' ],
			large:    [ '981px',   '1280px' ],
			medium:   [ '737px',   '980px'  ],
			small:    [ '481px',   '736px'  ],
			xsmall:   [ null,      '480px'  ]
		});

	// Play initial animations on page load.
		$window.on('load', function() {
			window.setTimeout(function() {
				$body.removeClass('is-preload');
			}, 100);
		});

	// Mobile?
		if (browser.mobile)
			$body.addClass('is-mobile');
		else {

			breakpoints.on('>medium', function() {
				$body.removeClass('is-mobile');
			});

			breakpoints.on('<=medium', function() {
				$body.addClass('is-mobile');
			});

		}

	// Scrolly.
		$('.scrolly')
			.scrolly({
				speed: 1500,
				offset: $header.outerHeight()
			});

	// Menu.
		$('#menu')
			.append('<a href="#menu" class="close"></a>')
			.appendTo($body)
			.panel({
				delay: 500,
				hideOnClick: true,
				hideOnSwipe: true,
				resetScroll: true,
				resetForms: true,
				side: 'right',
				target: $body,
				visibleClass: 'is-menu-visible'
			});

	// Header.
		if ($banner.length > 0
		&&	$header.hasClass('alt')) {

			$window.on('resize', function() { $window.trigger('scroll'); });

			$banner.scrollex({
				bottom:		$header.outerHeight() + 1,
				terminate:	function() { $header.removeClass('alt'); },
				enter:		function() { $header.addClass('alt'); },
				leave:		function() { $header.removeClass('alt'); }
			});

		}

	// Slideshow functionality - supports multiple independent slideshows
		function initSlideshows() {
			document.querySelectorAll('.slideshow-container').forEach(function(container, index) {
				container.setAttribute('data-slideshow-id', index);
				container.setAttribute('data-current-slide', '0');

				// Ensure first slide is active
				const slides = container.querySelectorAll('.slide');
				slides.forEach((slide, i) => {
					slide.classList.toggle('active', i === 0);
				});
			});
		}

		function changeSlide(n, containerId) {
			const container = document.querySelector(`[data-slideshow-id="${containerId}"]`);
			if (!container) return;

			const slides = container.querySelectorAll('.slide');
			if (slides.length === 0) return;

			let currentSlide = parseInt(container.getAttribute('data-current-slide'));
			slides[currentSlide].classList.remove('active');
			currentSlide = (currentSlide + n + slides.length) % slides.length;
			container.setAttribute('data-current-slide', currentSlide);
			slides[currentSlide].classList.add('active');
		}

		// Initialize slideshows when DOM is ready
		window.changeSlide = changeSlide;
		if (document.readyState === 'loading') {
			document.addEventListener('DOMContentLoaded', initSlideshows);
		} else {
			initSlideshows();
		}

})(jQuery);
