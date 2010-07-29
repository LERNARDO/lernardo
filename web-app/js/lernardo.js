// hides an element
hideform = function(id) {
  $(id).hide('slow');
};

// shows an element
showform = function(id) {
  $(id).show('slow');
};

// clears the text of an element
cleartext = function(){
  document.getElementById('hide').value='';
};

// shows the spinner
showspinner = function(id) {
  $(id).html('<img id="spinner" src="http://sueninos.lernardo.net/images/spinner.gif" alt="Spinner"/>');
};

//toggle element
toggle = function(id) {
  $(id).toggle(400);
}