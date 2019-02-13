
define(['jquery', 'core/notification'], function($, notification) {
    var show_dialog_success = function() {
        notification.alert("Evaluation erfolgreich",
            "Sie haben die Evaluation erfolgreich beantragt. <br />" +
            "!!!DIE EVALUATION HAT NOCH NICHT BEGONNEN!!! <br />" +
            "Sie müssen allerdings nichts weiter tun, " +
            "ihr Evaluationsbeauftragter wird nun nach dem Verfahren ihres Fachbereichs weiter verfahren.",
            "Verstanden");
    };

    var show_dialog_up_to_date = function() {
        notification.alert("Evaluation bereits beantragt",
            "Ihr Evaluationsbeauftragter hat bereist einen Auftrag zum durchführen der Evaluation von ihnen erhalten. <br />" +
            "Für Fragen zum Status ihrer Evaluation kontaktieren sie bitte ihren Evaluationsbeauftragten.",
            "Verstanden");
    };

    var show_dialog_failure = function() {
        notification.alert("Evaluation nicht beauftragt",
            "Leider konnten keine Einladungen versentdet werden. <br />" +
            "Bitte wenden sie sich an den Support.",
            "Verstanden");
    };

    return {
        show_dialog_failure: show_dialog_failure,
        show_dialog_success: show_dialog_success,
        show_dialog_up_to_date: show_dialog_up_to_date
    };
});