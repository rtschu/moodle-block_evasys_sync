// Sorry Justus.
define(['core/str', 'core/notification', 'core/url', 'jquery'], function (str, notification, url, $) {

    var updateForm = function (dates) {
        var form = document.getElementById('evasys_block_form');
        for (var i = 0; i < dates.count; i++) {
            form.elements['startDate' + i].value = dates["startDate" + i];
            form.elements['endDate' + i].value = dates["endDate" + i];
        }
    };

    var call = function (dates) {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                if (this.responseText === "success inviting") {
                    str.get_strings([
                        {'key': 'title_success', component: 'block_evasys_sync'},
                        {'key': 'content_success_invite', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                        ]).done(function (s) {
                            notification.alert(s[0], s[1], s[2]);
                        });
                    updateForm(dates);
                } else if (this.responseText === "success") {
                    str.get_strings([
                        {'key': 'title_success', component: 'block_evasys_sync'},
                        {'key': 'content_success', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                    updateForm(dates);
                } else if (this.responseText === "Start after end") {
                    str.get_strings([
                        {'key': 'title_date_invalid', component: 'block_evasys_sync'},
                        {'key': 'coontent_start_after_end', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else if (this.responseText === "Start in the past") {
                    str.get_strings([
                        {'key': 'title_date_invalid', component: 'block_evasys_sync'},
                        {'key': 'content_invalidstart', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else if (this.responseText === "End in the past") {
                    str.get_strings([
                        {'key': 'title_date_invalid', component: 'block_evasys_sync'},
                        {'key': 'content_invalidend', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    });
                } else if (this.responseText === "wrong mode") {
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

    var ajax = function (dates) {
        call(dates);
    };

    var init = function () {
        // Overwrite standard submit function.
        $('#evasys_block_form').submit(function (e) {
            // We don't wanna get redirected.
            e.preventDefault();
            // Also we don't want someone to send another ajax because the first one didn't compvare yet.
            $('#evasys_block_form').find(':input[type=submit]').prop('disabled', true);
            // Call to invite.php with data being passed to it.
            var data = {};
            $('#evasys_block_form').serializeArray().forEach(function (param) {
                data[param['name']] = param['value'];
            });
            ajax(data);
        });
    };

    return {
        ajax: ajax,
        init: init,
    };
});