define(['core/str', 'core/notification', 'core/url'], function ajax(str, notification, url) {

    var call = function (id, dates) {
        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if(this.readyState === 4 && this.status === 200){
                console.log("hi");
                if(this.responseText.includes(" emails sent successful")) {
                    number = this.responseText.replace(" emails sent successful.", "");
                    sent1 = number.split("/")[0];
                    total1 = number.split("/")[1];
                    params = {"sent": sent1, "total": total1};
                    str.get_strings([
                        {'key': 'title_send_success', component: 'block_evasys_sync'},
                        {'key': 'content_send_success', component: 'block_evasys_sync', param: params},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    })
                }else if(this.responseText === "-1"){
                    str.get_strings([
                        {'key': 'direct_title_info', component: 'block_evasys_sync'},
                        {'key': 'direct_already', component: 'block_evasys_sync'},
                        {'key': 'ok'}
                    ]).done(function (s) {
                        notification.alert(s[0], s[1], s[2]);
                    })
                }else{
                    notification.alert("Erfolg", this.responseText, "ok");
                }
            }else if(this.readyState === 4){
                str.get_string('send_error', 'block_evasys_sync').done(function (s) {
                    notification.alert("Error", s, "OK");
                });
                console.log(this.responseText);
                notification.alert("Erfolg", this.responseText, "ok");
            }
        };
        dates["courseid"] = id;
        s = url.relativeUrl("/blocks/evasys_sync/invite.php", dates, true);
        console.log("URL: " + s);
        console.log(dates.toSource());
        xhttp.open("GET", s);
        xhttp.send();
    };

    var ajax = function (id, dates) {
        str.get_strings([
            {'key' : 'direct_invite', component: 'block_evasys_sync'},
            {'key' : 'content_confirm', component: 'block_evasys_sync'},
            {'key' : 'yes'},
            {'key' : 'no'},
        ]).done(function (s) {
            notification.confirm(s[0], s[1], s[2], s[3], function () {
                call(id, dates);
            });
        })
    };
    return{
        ajax: ajax,
    };
});