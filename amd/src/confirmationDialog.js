define(['jquery', 'core/modal_factory'], function($, ModalFactory) {
    var trigger = $('#create-modal');
    init: ModalFactory.create({
        title: 'test title',
        body: '<p>test body content</p>',
        footer: 'test footer content',
    }, trigger)
        .done(function(modal) {
            // Do what you want with your new modal.
        });
});