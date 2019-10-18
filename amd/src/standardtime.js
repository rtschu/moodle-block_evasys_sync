define(['jquery'], function($) {
    var init = function() {
        if ($('#activate_standard').length > 0) {
            $(document).on("change", "#activate_standard", function () {
                if (this.checked) {
                    $('#inputfieldset').prop("hidden", true);
                } else {
                    $('#inputfieldset').prop("hidden", false);
                }
            });
        }
    };

    return {
        init: init
    };
});