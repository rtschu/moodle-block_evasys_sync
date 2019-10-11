define(['core/str', 'core/notification', 'core/url', 'jquery'], function (str, notification, url, $) {
    var updateParticipants = function(participants) {
        var participantFields = $('.block_evasys_participants');
        participantFields.each(function() {
            this.innerHTML = participants;
        });
    };

    var submitInvitation = function (dates) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                var responseParts = this.responseText.split('#');
                if (responseParts[0] === "success inviting") {
                    updateParticipants(responseParts[1]);
                    str.get_strings([
                        {'key': 'title_success', component: 'block_evasys_sync'},
                        {'key': 'content_success_invite', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                        ]).done(function (s) {
                            notification.alert(s[0], s[1], s[2]);
                        });
                } else if (responseParts[0] === "success") {
                    str.get_strings([
                        {'key': 'title_success', component: 'block_evasys_sync'},
                        {'key': 'content_success_direct', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else if (responseParts[0] === "Start after end") {
                    str.get_strings([
                        {'key': 'title_date_invalid', component: 'block_evasys_sync'},
                        {'key': 'content_start_after_end', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else if (responseParts[0] === "End in the past") {
                    str.get_strings([
                        {'key': 'title_date_invalid', component: 'block_evasys_sync'},
                        {'key': 'content_invalidend', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else if (responseParts[0] === "wrong mode") {
                    str.get_strings([
                        {'key': 'title_wrong_mode', component: 'block_evasys_sync'},
                        {'key': 'content_wrong_mode', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else {
                    str.get_string('send_error', 'block_evasys_sync').done(function (s) {
                        notification.alert("Error", s, "OK");
                    });
                }
            } else if (this.readyState === 4) {
                str.get_string('send_error', 'block_evasys_sync').done(function (s) {
                    notification.alert("Error", s, "OK");
                });
            }
            if (this.readyState === 4) {
                $('#evasys_block_form').find(':input[type=submit]').prop('disabled', false);
            }
        };
        var s = url.relativeUrl("/blocks/evasys_sync/invite.php", dates, true);
        xhttp.open("GET", s);
        xhttp.send();
    };

    var init = function () {
        // Overwrite standard submit function.
        $('#evasys_block_form').submit(function (e) {
            // We don't wanna get redirected.
            e.preventDefault();
            // Also we don't want someone to send another ajax because the first one didn't compvare yet.
            $('#evasyssubmitbutton').prop('disabled', true);
            // Call to invite.php with data being passed to it.
            var data = {};
            $('#evasys_block_form').serializeArray().forEach(function (param) {
                data[param['name']] = param['value'];
            });
            submitInvitation(data);
        });

        if ($('#direct_invite').length > 0) {
            str.get_strings([
                {'key': 'planorstartevaluation', component: 'block_evasys_sync'},
                {'key': 'startevaluationnow', component: 'block_evasys_sync'}
            ]).done(function (s) {
                $('#direct_invite').change(function() {
                    if(this.checked) {
                        $('#evasyssubmitbutton').val(s[1]);
                    } else {
                        $('#evasyssubmitbutton').val(s[0]);
                    }
                });
            });
        }
    };

    return {
        init: init
    };
});