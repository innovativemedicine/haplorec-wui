// Prevent app from being redefined during ajax fetches that return a <script src="application.js">
if (typeof app === 'undefined') {
    var app = (function (m, Spinner, jQuery) {
        m.spinner = new Spinner({
            lines: 13, // The number of lines to draw
            length: 3, // The length of each line
            width: 4, // The line thickness
            radius: 10, // The radius of the inner circle
            corners: 1, // Corner roundness (0..1)
            rotate: 0, // The rotation offset
            color: 'white', // #rgb or #rrggbb
            speed: 1, // Rounds per second
            trail: 60, // Afterglow percentage
            shadow: false, // Whether to render a shadow
            hwaccel: false, // Whether to use hardware acceleration
            className: 'spinner', // The CSS class to assign to the spinner
            zIndex: 2e9, // The z-index (defaults to 2000000000)
            top: 'auto', // Top position relative to parent in px
            left: 'auto', // Left position relative to parent in px
            visibility: true
        });

        var spinnerContainer = $('.spinner-container');
        m.spinning = false;
        m.startSpinner = function () {
            if (spinnerContainer != null && !m.spinning) {
                m.spinner.spin(spinnerContainer.get(0));
                m.spinning = true;
            }
        };

        m.stopSpinner = function () {
            if (m.spinning) {
                m.spinner.stop();
                m.spinning = false;
            }
        };

		$(document).ajaxStart(function() {
            m.startSpinner();
		}).ajaxStop(function() {
            m.stopSpinner();
		});

        // we assume the client will get redirected, so no need to stop the spinner
        $('input.save[type="submit"], input.delete[type="submit"]').click(m.startSpinner);

        return m;
    })(app || {}, Spinner, jQuery || undefined);
}
