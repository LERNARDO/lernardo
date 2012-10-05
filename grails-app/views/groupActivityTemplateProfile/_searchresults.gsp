<g:if test="${allTemplates}">

  <p style="margin-top: 10px"><a href="" onclick="selectall(); return false"><g:message code="select.all"/></a> - <a href="" onclick="deselectall(); return false"><g:message code="select.none"/></a></p>

  <table>
    <tr>
      <td>
        <g:each in="${allTemplates.size() % 2 == 0 ? allTemplates.subList(0, (allTemplates.size() / 2).toInteger()) : allTemplates.subList(0, ((allTemplates.size() + 1) / 2).toInteger())}" var="searchInstance">
          <g:checkBox name="memberchecked" id="${searchInstance.id}" value="${true}" /> <g:link controller="templateProfile" action="show" id="${searchInstance.id}">${searchInstance.profile}</g:link> <span class="gray">(${searchInstance.profile.duration} min)</span><br/>
        </g:each>
      </td>
      <td valign="top" style="padding-left: 50px;">
        <g:each in="${allTemplates.size() % 2 == 0 ? allTemplates.subList((allTemplates.size() / 2).toInteger(), allTemplates.size()) : allTemplates.subList(((allTemplates.size() + 1) / 2).toInteger(), allTemplates.size())}" var="searchInstance">
          <g:checkBox name="memberchecked" id="${searchInstance.id}" value="${true}" /> <g:link controller="templateProfile" action="show" id="${searchInstance.id}">${searchInstance.profile}</g:link> <span class="gray">(${searchInstance.profile.duration} min)</span><br/>
        </g:each>
      </td>
    </tr>
  </table>

  <script type="text/javascript">

  function selectall() {
    for (var zaehler = 0; zaehler < (document.getElementsByName("memberchecked").length); zaehler++) {
      document.getElementsByName("memberchecked")[zaehler].checked = true;
    }
  }

  function deselectall() {
    for (var zaehler = 0; zaehler < (document.getElementsByName("memberchecked").length); zaehler++) {
      document.getElementsByName("memberchecked")[zaehler].checked = false;
    }
  }

  function kontrolle() {

    var selector = document.getElementById("selector");
    if (selector)
      document.getElementById("hidden2").removeChild(selector);

    var wme = document.createElement("select");
    wme.id = "selector";
    wme.name = "templates";
    wme.multiple = true;

    var checked = new Array();
      for (var zaehler = 0; zaehler < (document.getElementsByName("memberchecked").length); zaehler++) {
       if (document.getElementsByName("memberchecked")[zaehler].checked) {

         checked.push(document.getElementsByName("memberchecked")[zaehler].id);

         var optn = document.createElement("OPTION");
         optn.text = document.getElementsByName("memberchecked")[zaehler].id;
         optn.value = document.getElementsByName("memberchecked")[zaehler].id;
         optn.selected = true;
         wme.options.add(optn);
       }
    }

    document.getElementById("hidden2").appendChild(wme);
  }

  </script>

  <div id="hidden2" style="display: none"></div>

  <g:submitButton style="margin-top: 5px" onclick="kontrolle();" name="button" value="${message(code:'add')}"/>
  <div class="clear"></div>

</g:if>
<g:else>
  <span class="italic red"><g:message code="noResults"/></span>
</g:else>