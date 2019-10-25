define(['jquery', 'core/modal_factory', 'core/templates', 'core/str', 'core/url'], function ($, ModalFactory, Templates, str, url) {

    var get_timestamp = function () {
        var startmin = $('[name=minute_start]').last()[0].selectedIndex;
        var starthour = $('[name=hour_start]').last()[0].selectedIndex;
        var startday = $('[name=day_start]').last()[0].selectedIndex;
        var startmonth = $('[name=month_start]').last()[0].selectedIndex;
        var startyear = $('[name=year_start]').last()[0].selectedIndex + 2000;

        var endmin = $('[name=minute_end]').last()[0].selectedIndex;
        var endhour = $('[name=hour_end]').last()[0].selectedIndex;
        var endday = $('[name=day_end]').last()[0].selectedIndex;
        var endmonth = $('[name=month_end]').last()[0].selectedIndex;
        var endyear = $('[name=year_end]').last()[0].selectedIndex + 2000;
        var startdate = new Date(startyear, startmonth, startday + 1, starthour, startmin);
        var enddate = new Date(endyear, endmonth, endday + 1, endhour, endmin);
        return {
            'starttime': startdate.getTime() / 1000,
            'endtime': enddate.getTime() / 1000
        }
    };

    var ready = function () {
        // If you ever need a callback.
    };

    var initialize = function (startdates, enddates) {
        var i = 0;
        str.get_string('edit_time', 'block_evasys_sync').done(function (s) {
            while (true) {
                var element = $("#timeediturl_" + i);
                if (element.length <= 0) {
                    break;
                }
                element.on('click', function (e) {
                    var clickedLink = $(e.currentTarget);
                    ModalFactory.create({
                        type: ModalFactory.types.SAVE_CANCEL,
                        title: s,
                        body: Templates.render('block_evasys_sync/edittime', {}),
                    })
                        .then(function (modal) {
                            var root = modal.getRoot();
                            root.on('modal-save-cancel:save', function () {
                                var saveid = new URL(clickedLink.prop('href')).searchParams.get("id");
                                var times = get_timestamp();
                                times.category = saveid;
                                var xhttp = new XMLHttpRequest();
                                xhttp.onreadystatechange = ready;
                                var s = url.relativeUrl("/blocks/evasys_sync/alterstandardtime.php", times, true);
                                xhttp.open('GET', s);
                                xhttp.send();
                                var elementNo = clickedLink.prop('id').split("_")[1];
                                startdates[elementNo] = times.starttime;
                                enddates[elementNo] = times.endtime;
                            });
                            modal.show();
                            require(['block_evasys_sync/initialize'], function(timesetter){
                                var elementNo = clickedLink.prop('id').split("_")[1];
                                if(startdates[elementNo] == null || startdates[elementNo] == undefined) {
                                    startdates[elementNo] = Date.now() / 1000;
                                    enddates[elementNo] = Date.now() / 1000;
                                }
                                timesetter.init(startdates[elementNo], enddates[elementNo]);
                            });

                        });
                });
                i++;
            }
        });
    };
    return {
        initialize: initialize,
    }
});