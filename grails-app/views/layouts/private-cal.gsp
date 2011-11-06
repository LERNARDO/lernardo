<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <g:set var="customer" value="${grailsApplication.config.customer}"/>
  <less:stylesheet name="common" />
  <less:stylesheet name="${customer}" />
  <less:scripts />
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <g:javascript src="jquery/fullcalendar.min.js"/>
  <link rel="stylesheet" href="${resource(dir:'css',file:'fullcalendar.css')}">

  <script type="text/javascript">
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

    // toggle elements
    newtoggle = function(id) {
      $('#personcolor' + id).toggle();
      $('#personcolor' + id + '-2').toggle();
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

  <ga:trackPageview />
  <g:layoutHead />

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
    </div>

    %{--<div style="background: #fff;">
      <g:render template="/templates/imagenav"/>
    </div>--}%

    <div class="yui3-g" id="grid-cal">

      <g:if test="${flash.message}">
        <div id="flash-msg">
          ${flash.message}
        </div>
      </g:if>

      <div class="yui3-u" id="cal-left">
        
        <div style="font-size: 18px; margin: 0 0 10px 10px;"><g:message code="imgmenu.calendar.name"/></div>

        <erp:getActiveCalPerson id="${currentEntity.id}">
          <div class="calenderperson">
            <table style="width: 100%;">
              <tr>
                <td>
                  <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('person','${currentEntity.id}','-1'); return false;">
                    <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${currentEntity.id}','${i}','${active}');"/>
                    <div id="personcolor-1" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${currentEntity.profile.color ?: '#ccc'}; background-color: ${currentEntity.profile.color ?: '#ccc'};"></div> <erp:truncate string="${currentEntity.profile.fullName}"/></div>
                    <div id="personcolor-1-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${currentEntity.profile.fullName}"/></div>
                  </a>
                </td>
              </tr>
            </table>
          </div>
        </erp:getActiveCalPerson>
        <div class="calenderperson">
          <table style="width: 100%;">
            <tr>
              <td>
                <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); toggleThemes(); return false;">
                  <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialThemes('${currentEntity.profile.calendar.showThemes}');"/>
                  <div id="theme1" style="display: ${currentEntity.profile.calendar.showThemes ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #000; background-color: #000;"></div> <g:message code="themes"/></div>
                  <div id="theme2" style="display: ${currentEntity.profile.calendar.showThemes ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <g:message code="themes"/></div>
                </a>
              </td>
            </tr>
          </table>
        </div>
    
        <div style="border-bottom: 1px solid #ddd; margin: 5px 0;"></div>

        <div style="font-size: 12px; margin: 0 0 5px 10px;"><g:message code="operators"/></div>

        <g:each in="${operators}" var="operator" status="i">
          <erp:getActiveCalPerson id="${operator.id}">
            <div class="calenderperson">
              <table style="width: 100%;">
                <tr>
                  <td>
                    <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('operator','${operator.id}','${i}'); return false;">
                      <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${operator.id}','${i}','${active}');"/>
                      <div id="operatorcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${operator.profile.color ?: '#ccc'}; background-color: ${operator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${operator.profile.fullName}"/></div>
                      <div id="operatorcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${operator.profile.fullName}"/></div>
                    </a>
                  </td>
                </tr>
              </table>
            </div>
          </erp:getActiveCalPerson>
        </g:each>

        <div style="border-bottom: 1px solid #ddd; margin: 5px 0;"></div>

        <div style="font-size: 12px; margin: 0 0 5px 10px;"><g:message code="educators"/></div>

        <div style="margin: 10px 0 0 8px; font-size: 12px;">
          <g:formRemote name="form" url="[controller: 'calendar', action: 'sort']" update="results">
            <g:select name="sort" from="['first', 'last']" valueMessagePrefix="sortBy"/>
          </g:formRemote>

          <script type="text/javascript">
            $("select[name=sort]").change(function() {
              $("form[id=form]").submit();
            });
          </script>

        </div>

        <div id="results">
          <g:each in="${educators}" var="educator" status="i">
            <erp:getActiveCalPerson id="${educator.id}">
              <div class="calenderperson">
                <table style="width: 100%;">
                  <tr>
                    <td>
                      <a style="display: block; text-decoration: none;" href="#" onclick="showBigSpinner(); togglePerson('person','${educator.id}','${i}'); return false;">
                        <img style="display: none" src="${resource(dir: 'images/icons', file: 'icon_person.png')}" alt="person" onload="showInitialEvents('${educator.id}','${i}','${active}');"/>
                        <div id="personcolor${i}" style="display: ${active ? 'block' : 'none'}; color: #000;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid ${educator.profile.color ?: '#ccc'}; background-color: ${educator.profile.color ?: '#ccc'};"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
                        <div id="personcolor${i}-2" style="display: ${active ? 'none' : 'block'}; color: #555;"><div style="float: left; margin-right: 5px; width: 12px; height: 12px; border: 1px solid #bbb; background-color: #fff;"></div> <erp:truncate string="${educator.profile.fullName}"/></div>
                      </a>
                    </td>
                  </tr>
                </table>
              </div>
            </erp:getActiveCalPerson>
          </g:each>
        </div>
        <div class="clear"></div>
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
    if (active == "true")
      $('.cal').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
  };

  showInitialThemes = function(active){
      if (active == "true")
        $('.cal').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
    };

  togglePerson = function(element, id, i){
    $('#' + element + 'color' + i).toggle();
    $('#' + element + 'color' + i + '-2').toggle();

    $.ajax({
      url: '${createLink (controller: "calendar", action: "togglePersonInCal")}',
      dataType: 'text',
      data: "id="+id,
      success: function(result) {
        if (result == "true") {
          $('.cal').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
          hideBigSpinner();
        }
        else if (result == "false") {
          $('.cal').fullCalendar('removeEventSource', '${createLink (controller: "calendar", action: "togglePerson")}?id='+id);
          hideBigSpinner();
        }
      }
    });

  };

  toggleThemes = function(){
    $('#theme1').toggle();
    $('#theme2').toggle();

    $.ajax({
      url: '${createLink (controller: "calendar", action: "toggleThemesInCal")}',
      dataType: 'text',
      success: function(result) {
        if (result == "true") {
          $('.cal').fullCalendar('addEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
          hideBigSpinner();
        }
        else if (result == "false") {
          $('.cal').fullCalendar('removeEventSource', '${createLink (controller: "calendar", action: "toggleThemes")}');
          hideBigSpinner();
        }
      }
    });

  };
</script>
</html>