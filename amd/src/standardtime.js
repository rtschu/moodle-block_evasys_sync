define(['jquery'], function($) {
    var init = function() {
        if ($('#activate_standard').length > 0) {
            $(document).on("change", "#activate_standard", function () {
                if (this.checked) {
                    $('#inputfieldset').prop("disabled", true);
                    disable();
                } else {
                    $('#inputfieldset').prop("disabled", false);
                    enable();
                }
            });
        }
    };

    var disable = function() {
        $('[name=minute_start]')[0].disabled = true;
        $('[name=hour_start]')[0].disabled = true;
        $('[name=day_start]')[0].disabled = true;
        $('[name=month_start]')[0].disabled = true;
        $('[name=year_start]')[0].disabled = true;
        $('[name=minute_end]')[0].disabled = true;
        $('[name=hour_end]')[0].disabled = true;
        $('[name=day_end]')[0].disabled = true;
        $('[name=month_end]')[0].disabled = true;
        $('[name=year_end]')[0].disabled = true;
        $('#only_end').val(false);
    };

    var enable = function() {
        $('[name=minute_start]')[0].disabled = false;
        $('[name=hour_start]')[0].disabled = false;
        $('[name=day_start]')[0].disabled = false;
        $('[name=month_start]')[0].disabled = false;
        $('[name=year_start]')[0].disabled = false;
        $('[name=minute_end]')[0].disabled = false;
        $('[name=hour_end]')[0].disabled = false;
        $('[name=day_end]')[0].disabled = false;
        $('[name=month_end]')[0].disabled = false;
        $('[name=year_end]')[0].disabled = false;
    };

    return {
        init: init
    };
});