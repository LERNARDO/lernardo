%{--  Home with own Profile; Userdaten erforderlich  --}%
%{--
$(document).bind('keydown', 'alt+h', function(){
    showBigSpinner();
    $.get("${createLink(controller: "userProfile", action: "show")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Documents; Userdaten erforderlich--}%
%{--
$(document).bind('keydown', 'alt+d', function(){
    showBigSpinner();
    $.get("${createLink(controller: "publication")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Create Message; Userdaten erforderlich  --}%
%{--
$(document).bind('keydown', 'alt+m', function(){
    showBigSpinner();
    $.get("${createLink(controller: "msg", action: "createMany")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Aktivitätsvorlagen Liste --}%
$(document).bind('keydown', 'alt+a', function(){
    showBigSpinner();
    $.get("${createLink(controller: "templateProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Akltivitätsvorlagen Create; durch Ajax Fehler bei Msg-Box; alt+ctrl+a nicht !!!???? --}%
%{--
$(document).bind('keydown', 'alt+ctrl+a', function(){
    showBigSpinner();
    $.get("${createLink(controller: "templateProfile", action: "create")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Aktivitätsblockvorlagen Liste --}%
$(document).bind('keydown', 'alt+b', function(){
    showBigSpinner();
    $.get("${createLink(controller: "groupActivityTemplateProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Aktivitätsblockvorlagen Create; ; durch Ajax Fehler bei Beschreibung...; --}%
%{--
$(document).bind('keydown', 'alt+ctrl+b', function(){
    showBigSpinner();
    $.get("${createLink(controller: "groupActivityTemplateProfile", action: "create")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Aktivitätsblock Liste; durch Ajax Fehler bei Datum; --}%
%{--
$(document).bind('keydown', 'alt+shift+b', function(){
    showBigSpinner();
    $.get("${createLink(controller: "groupActivityProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Projektvorlage Liste --}%
$(document).bind('keydown', 'alt+p', function(){
    showBigSpinner();
    $.get("${createLink(controller: "projectTemplateProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Projektvorlage Create; durch Ajax Fehler bei Beschreibung...; --}%
%{--
$(document).bind('keydown', 'alt+ctrl+p', function(){
    showBigSpinner();
    $.get("${createLink(controller: "projectTemplateProfile", action: "create")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Projekte Liste; durch Ajax Fehler bei Datum; --}%
%{--
$(document).bind('keydown', 'alt+shift+p', function(){
    showBigSpinner();
    $.get("${createLink(controller: "projectProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Thema Liste; --}%
$(document).bind('keydown', 'alt+t', function(){
    showBigSpinner();
    $.get("${createLink(controller: "themeProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Thema Create; durch Ajax Fehler bei Datum und Textfelder; --}%
%{--
$(document).bind('keydown', 'alt+ctrl+t', function(){
    showBigSpinner();
    $.get("${createLink(controller: "themeProfile", action: "create" )}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Zeitaufzeichnung; Userdaten erforderlich  --}%
%{--
$(document).bind('keydown', 'alt+r', function(){
    showBigSpinner();
    $.get("${createLink(controller: "workdayUnit")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Zeitauswertung; durch Ajax Fehler bei Datum;--}%
%{--
$(document).bind('keydown', 'alt+shift+r', function(){
    showBigSpinner();
    $.get("${createLink(controller: "workdayUnit", action: "evaluation")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Benachrichtigung; durch Ajax Fehler bei Multiline-Felder  --}%
%{--
$(document).bind('keydown', 'alt+n', function(){
    showBigSpinner();
    $.get("${createLink(controller: "profile", action: "createNotification")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Setup; durch Ajax Fehler mit Werkzeugen bei Einträgen  --}%
%{--
$(document).bind('keydown', 'alt+s', function(){
    showBigSpinner();
    $.get("${createLink(controller: "setup", action: "show")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Logbuch; durch Ajax Fehler bei Datum;--}%
%{--
$(document).bind('keydown', 'alt+l', function(){
    showBigSpinner();
    $.get("${createLink(controller: "logBook", action: "entries")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Logbuch Auswertung;--}%
$(document).bind('keydown', 'alt+shift+l', function(){
    showBigSpinner();
    $.get("${createLink(controller: "logBook", action: "evaluation")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Educator List  --}%
$(document).bind('keydown', 'alt+e', function(){
    showBigSpinner();
    $.get("${createLink(controller: "educatorProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Educator Create; durch Ajax Fehler bei Datum; --}%
%{--
$(document).bind('keydown', 'alt+ctrl+e', function(){
    showBigSpinner();
    $.get("${createLink(controller: "educatorProfile", action: "create")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Client List  --}%
$(document).bind('keydown', 'alt+c', function(){
    showBigSpinner();
    $.get("${createLink(controller: "clientProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Client create; durch Ajax Fehler bei Datum;  --}%
%{--
$(document).bind('keydown', 'alt+ctrl+c', function(){
    showBigSpinner();
    $.get("${createLink(controller: "clientProfile", action: "create")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

%{-- Erziehungsberechtigter List  --}%
$(document).bind('keydown', 'alt+g', function(){
    showBigSpinner();
    $.get("${createLink(controller: "parentProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});

%{-- Erziehungsberechtigter Create; durch Ajax Fehler bei Datum und multiline;  --}%
%{--
$(document).bind('keydown', 'alt+ctrl+g', function(){
    showBigSpinner();
    $.get("${createLink(controller: "parentProfile", action: "create")}", function(data) {
        $('body').html(data);
    });
    return false;
});
--}%

