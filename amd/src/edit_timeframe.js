define(['jquery', 'core/modal_factory', 'core/templates'], function ($, ModalFactory, Templates) {
    var init = function () {
        var i = 0;
        while(true) {
            var element = $("#timeediturl_" + i);
            if (element.length <= 0) {
                break;
            }
            element.on('click', function (e) {
                var clickedLink = $(e.currentTarget);
                ModalFactory.create({
                    type: ModalFactory.types.SAVE_CANCEL,
                    title: 'CHANGE THIS!!! NEEDS TO USE STRING FROM LANG',
                    body: Templates.render('block_evasys_sync/edittime', {}),
                })
                    .then(function (modal) {
                        var root = modal.getRoot();
                        root.on('modal-save-cancel:save', function() {
                            var saveid = clickedLink.data('id');
                        });
                        modal.show();
                    });
            });
            i++;
        }
    };
    return {
        init: init,
    }
});