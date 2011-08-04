<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.projectName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <g:set var="project" value="${grailsApplication.config.project}"/>
  <less:stylesheet name="common" />
  <less:stylesheet name="${project}" />
  <less:scripts />
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <g:javascript src="jquery/fullcalendar.min.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}">
  %{--<g:javascript src="jquery/jquery.miniColors.min.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'jquery.miniColors.css')}"/>--}%

  <script type="text/javascript">
    /*$(document).ready( function() {
      $(".colors").miniColors({

            change: function(hex, rgb) {
              $("#console").prepend('HEX: ' + hex + ' (RGB: ' + rgb.r + ', ' + rgb.g + ', ' + rgb.b + ')<br />');
            }

          });
    });*/

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
      $(id).html('<img id="spinner" src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Lade.."/>');
    };

    // toggle element
    toggle = function(id) {
      $(id).toggle(400);
    };

    // fadetoggle element
    ftoggle = function(id) {
      $(id).fadeToggle(400);
    };

    clearElements = function(elements) {
      for (x = 0; x <= elements.length; x++)
        $(elements[x]).val('');
    };

    function showBigSpinner() {
        $('#loading').css('visibility', 'visible');
      }

    function hideBigSpinner() {
        $('#loading').css('visibility', 'hidden');
      }

  </script>

  <ga:trackPageviewAsynch />
  <g:layoutHead/>

</head>
<body>

<div id="loading" style="position:absolute; left: 50%; text-align:center; top:50%; visibility: hidden;">
<img src="${resource(dir: 'images', file: 'big_spinner.gif')}" border=0></div>

<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>

<div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
      <g:render template="/templates/navigation"/>
    </div>

    <div style="background: #fff;">
      <g:render template="/templates/imagenav"/>
    </div>

    <div class="yui3-g" id="grid-cal">

      <g:if test="${flash.message}">
        <div id="flash-msg">
          ${flash.message}
        </div>
      </g:if>

      <div class="yui3-u" id="cal-left">
        <div class="boxHeader">
          <div class="second">
            <h1><g:message code="educators"/></h1>
          </div>
        </div>
        <div class="boxGray">
          <div class="second">
            <g:each in="${educators}" var="educator" status="i">
              <erp:getActiveEducator id="${educator.id}">
                <div class="calendereducator">
                  <table style="width: 100%;">
                    <tr>
                      <td style="height: 21px"><a style="display: block; color: #000; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('${educator.id}','${i}'); return false;"><img src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" align="top" onload="showInitialEvents('${educator.id}','${i}','${active}');"/> <erp:truncate string="${educator.profile.fullName}"/></a><div id="educatorcolor${i}" style="background: ${grailsApplication.config.colors[i]}; display: ${active ? 'block' : 'none'}; height: 22px; margin: -22px 0 0 0;"></div></td>
                      %{--<td><g:hiddenField name="color" class="colors" size="7" value="${educator?.profile?.color}"/></td>--}%
                    </tr>
                  </table>
                </div>
              </erp:getActiveEducator>
            </g:each>
            <div class="clear"></div>
          </div>
        </div>
        <p>
          <g:checkBox name="showThemes" value="${currentEntity.profile.calendar.showThemes}" onclick="toggleThemes()"/> Zeige Themen
        </p>
        <div id="console" style="width: 200px; background: #000; color: #fff;"></div>
      </div>
      <div class="yui3-u" id="main">
        <div id="private-content">
          <g:layoutBody/>
        </div>
      </div>

    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

</div>

</body>

<script type="text/javascript">

  showInitialEvents = function(id, i, active){
    //ftoggle('#educatorcolor' + i);
    if (active == "true")
      $('.cal').fullCalendar('addEventSource', '${createLink (controller:"calendar", action:"togglePerson")}?id='+id);
  };

  togglePerson = function(id, i){
    ftoggle('#educatorcolor' + i);

    $.ajax({
      url: '${createLink (controller:"calendar", action:"addOrRemove")}',
      dataType: 'text',
      data: "id="+id,
      success: function(result) {
        if (result == "true") {
          $('.cal').fullCalendar('addEventSource', '${createLink (controller:"calendar", action:"togglePerson")}?id='+id);
          hideBigSpinner();
        }
        else if (result == "false") {
          $('.cal').fullCalendar('removeEventSource', '${createLink (controller:"calendar", action:"togglePerson")}?id='+id);
          hideBigSpinner();
        }
      }
    });

  };

  toggleThemes = function(){

    $.ajax({
      url: '${createLink (controller:"calendar", action:"toggleT")}',
      dataType: 'text',
      success: function(result) {
        if (result == "true") {
          $('.cal').fullCalendar('addEventSource', '${createLink (controller:"calendar", action:"toggleThemes")}');
          hideBigSpinner();
        }
        else if (result == "false") {
          $('.cal').fullCalendar('removeEventSource', '${createLink (controller:"calendar", action:"toggleThemes")}');
          hideBigSpinner();
        }
      }
    });

  };
</script>
</html>