<g:if test="${allClients}">

  <p style="margin-top: 10px"><a href="" onclick="selectall(); return false"><g:message code="select.all"/></a> - <a href="" onclick="deselectall(); return false"><g:message code="select.none"/></a></p>

  <g:each in="${allClients}" var="searchInstance">
    <div class="member">

      <div class="member-pic">
        <g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">
          <erp:profileImage entity="${searchInstance}" width="50" height="50" align="left"/>
        </g:link>
      </div>

      <div class="member-info">
        <div class="member-name"><g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">${searchInstance.profile.fullName}</g:link></div>
        <div class="member-uni"><g:message code="profiletype.${searchInstance.type.supertype.name}"/></div>
        <g:checkBox name="memberchecked" id="${searchInstance.id}" value="${true}" />
      </div>

    </div>
  </g:each>
  <div class="spacer"></div>

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
      document.getElementById("hidden").removeChild(selector);

    var wme = document.createElement("select");
    wme.id = "selector";
    wme.name = "members";
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

    document.getElementById("hidden").appendChild(wme);
  }

  </script>

  <div id="hidden" style="display: none"></div>

  <g:submitButton style="margin-top: 5px" onclick="kontrolle();" name="button" value="${message(code:'add')}"/>
  <div class="spacer"></div>

</g:if>
<g:else>
  <span class="italic red"><g:message code="groupClient.clients.notFound"/>!</span>
</g:else>