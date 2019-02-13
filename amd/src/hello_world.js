
define(['jquery', 'core/notification'], function($, notification) {
    return {
        init: function() {
            notification.alert("Hello", "welcome", "continue");
        }
    };
});