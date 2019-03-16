define(['core/str', 'core/notification', 'core/url'], function ajax(str, notification, url) {

    var updateForm = function (dates) {
        let form = document.getElementById('evasys_block_form');
        for (let i = 0; i < dates.count; i++) {
            form.elements['startDate' + i].value = dates["start" + i];
            form.elements['endDate' + i].value = dates["end" + i];
        }
    };

    var call = function (id, dates) {
        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if(this.readyState === 4 && this.status === 200){
                if(this.responseText.includes("/")) {
                    let status = this.responseText.split("/");
                    if (status[0] === "success") {
                        params = {"sent": status[1], "total": status[2], "queued": status[3]};
                        str.get_strings([
                            {'key': 'title_send_success', component: 'block_evasys_sync'},
                            {'key': 'content_send_success', component: 'block_evasys_sync', param: params},
                            {'key': 'ok'}
                        ]).done(function (s) {
                            notification.alert(s[0], s[1], s[2]);
                            updateForm(dates);
                        })
                    } else {
                        str.get_string('send_error', 'block_evasys_sync').done(function (s) {
                            notification.alert("Error", s, "OK");
                        });
                    }
                }else if(this.responseText === "-1") {
                    str.get_strings([
                        {'key': 'direct_title_info', component: 'block_evasys_sync'},
                        {'key': 'direct_already', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    })
                }else if(this.responseText === "-2") {
                    str.get_strings([
                        {'key': 'title_send_failure', component: 'block_evasys_sync'},
                        {'key': 'not_enough_dates', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    })
                }else{
                    notification.alert("Fehler", this.responseText, "ok");
                }
            }else if(this.readyState === 4){
                str.get_string('send_error', 'block_evasys_sync').done(function (s) {
                    notification.alert("Error", s, "OK");
                });
                // Aconsole.log(this.responseText);
                // Anotification.alert("Erfolg", this.responseText, "ok");.
            }
        };
        dates["courseid"] = id;
        s = url.relativeUrl("/blocks/evasys_sync/invite.php", dates, true);
        xhttp.open("GET", s);
        xhttp.send();
    };

    var ajax = function (id, dates) {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
        var yyyy = today.getFullYear();

        today = yyyy + '-' + mm + '-' + dd;
        let confirm = false;
        for (let i = 0; i < dates.count; i++) {
            if(dates['start' + i] === today){
                confirm = true;
                break;
            }
        }
        if(confirm) {
            str.get_strings([
                {'key': 'direct_invite', component: 'block_evasys_sync'},
                {'key': 'content_confirm', component: 'block_evasys_sync'},
                {'key': 'yes'},
                {'key': 'no'},
            ]).done(function (s) {
                notification.confirm(s[0], s[1], s[2], s[3], function () {
                    call(id, dates);
                });
            })
        } else {
            call(id, dates);
        }
    };
    return{
        ajax: ajax,
    };
});