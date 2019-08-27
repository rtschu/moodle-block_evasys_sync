define(['jquery', 'core/notification', 'core/str'], function ($, notification, str) {
    var init = function(starttime, endtime) {
        var start = new Date(starttime * 1000);
        var end = new Date(endtime * 1000);
        if ($('[name=minute_start]').length == 0) {
            // No form present.
            return;
        }
        $('[name=minute_start]')[0].selectedIndex = start.getMinutes();
        $('[name=hour_start]')[0].selectedIndex = start.getHours();
        $('[name=day_start]')[0].selectedIndex = start.getDate() - 1;
        $('[name=month_start]')[0].selectedIndex = start.getMonth();
        $('[name=year_start]')[0].selectedIndex = start.getFullYear() - 2000;

        $('[name=minute_end]')[0].selectedIndex = end.getMinutes();
        $('[name=hour_end]')[0].selectedIndex = end.getHours();
        $('[name=day_end]')[0].selectedIndex = end.getDate() - 1;
        $('[name=month_end]')[0].selectedIndex = end.getMonth();
        $('[name=year_end]')[0].selectedIndex = end.getFullYear() - 2000;
        if ($('#reactivate').length > 0) {
            $(document).on("change", "#reactivate", function() {
                if (this.checked) {
                    // Ask for confirmation, then enable all fields related to re-invitation.
                    str.get_strings([
                        {'key': 'confirm'},
                        {'key': 'content_confirm_reactivate', component: 'block_evasys_sync'},
                        {'key': 'yes'},
                        {'key': 'no'}
                    ]).done(function(s) {
                        notification.confirm(s[0], s[1], s[2], s[3],
                            function () {
                                // User pressed yes.
                                $('[name=minute_start]')[0].disabled = false;
                                $('[name=hour_start]')[0].disabled = false;
                                $('[name=day_start]')[0].disabled = false;
                                $('[name=month_start]')[0].disabled = false;
                                $('[name=year_start]')[0].disabled = false;
                                if ($('#direct_invite').length > 0) {
                                    $('#direct_invite').prop('disabled', false);
                                }
                                if ($('#only_end').length > 0) {
                                    $('#only_end').prop("value", false);
                                }
                                if ($('#evasyssubmitbutton').length > 0) {
                                    $('#evasyssubmitbutton').prop("disabled", false);
                                }
                            },
                            function () {
                                // User pressed no.
                                $('#reactivate').prop("checked", false);
                            });
                    });
                } else {
                    // Disable all fields related to re-invitation.
                    $('[name=minute_start]')[0].disabled = true;
                    $('[name=hour_start]')[0].disabled = true;
                    $('[name=day_start]')[0].disabled = true;
                    $('[name=month_start]')[0].disabled = true;
                    $('[name=year_start]')[0].disabled = true;
                    if ($('#direct_invite').length > 0) {
                        $('#direct_invite').prop('disabled', true);
                    }
                    if ($('#only_end').length > 0) {
                        $('#only_end').prop("value", true);
                    }
                    if ($('#evasyssubmitbutton').length > 0) {
                        $('#evasyssubmitbutton').prop("disabled", true);
                    }
                }
            });
        }
        if ($('#direct_invite').length > 0) {
            $(document).on("change", "#direct_invite", function () {
                if (this.checked) {
                    // Disable startdate as evaluation will start immediately.
                    $('[name=minute_start]')[0].disabled = true;
                    $('[name=hour_start]')[0].disabled = true;
                    $('[name=day_start]')[0].disabled = true;
                    $('[name=month_start]')[0].disabled = true;
                    $('[name=year_start]')[0].disabled = true;
                } else {
                    // Allow user to set startdate.
                    $('[name=minute_start]')[0].disabled = false;
                    $('[name=hour_start]')[0].disabled = false;
                    $('[name=day_start]')[0].disabled = false;
                    $('[name=month_start]')[0].disabled = false;
                    $('[name=year_start]')[0].disabled = false;

                }
            });
        }
    };

    return {
        init: init
    };
});