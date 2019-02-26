define(['core/str', 'core/notification', 'core/url'], function ajax(str, notification, url) {

    var call = function (id) {
        let xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if(this.readyState === 4 && this.status === 200){
                number = this.responseText.replace(" emails sent successful.", "");
                sent1 = number.split("/")[0];
                total1 = number.split("/")[1];
                params = {"sent" : sent1, "total" : total1};
                str.get_strings([
                    {'key' : 'title_send_success', component: 'block_evasys_sync'},
                    {'key' : 'content_send_success', component: 'block_evasys_sync', param: params},
                    {'key' : 'ok'}
                ]).done(function (s) {
                    notification.alert(s[0], s[1], s[2]);
                })
            }else if(this.readyState === 4){
                str.get_string('send_error', 'block_evasys_sync').done(function (s) {
                    notification.alert("Error", s, "OK");
                });
                console.log(this.responseText);
            }
        };
        s = url.relativeUrl("/blocks/evasys_sync/invite.php", {"courseid": id}, true);
        console.log("URL: " + s);
        xhttp.open("GET", s);
        xhttp.send();
    };

    var ajax = function (id) {
        str.get_strings([
            {'key' : 'direct_invite', component: 'block_evasys_sync'},
            {'key' : 'content_confirm', component: 'block_evasys_sync'},
            {'key' : 'yes'},
            {'key' : 'no'},
        ]).done(function (s) {
            notification.confirm(s[0], s[1], s[2], s[3], function () {
                call(id);
            });
        })
    };
    return{
        ajax: ajax,
    };
});