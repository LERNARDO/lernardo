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
  $(id).html('<img id="spinner" src="../images/spinner.gif" alt="Lade.."/>');
};

// toggle element
toggle = function(id) {
  $(id).toggle(400);
};

// fadetoggle element
ftoggle = function(id) {
  $(id).fadeToggle(400);
};

// clears the value of multiple elements
clearElements = function(elements) {
    for each(element in elements)
        document.getElementById(element).value = "";
};