$(document).bind('keydown', 'ctrl+e', function(){
    showBigSpinner();
    $.get("${createLink(controller: "educatorProfile")}", function(data) {
        $('body').html(data);
    });
    return false;
});