<g:if test="${allClients}">

  <g:each in="${allClients}" var="searchInstance">
    <div class="member">

      <div class="member-pic">
        <g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">
          <ub:profileImage name="${searchInstance.name}" width="50" height="50" align="left"/>
        </g:link>
      </div>

      <div class="member-info">
        <div class="member-name"><g:link controller="${searchInstance.type.supertype.name +'Profile'}" action="show" id="${searchInstance.id}" params="[entity:searchInstance.id]">${searchInstance.profile.fullName}</g:link></div>
        <div class="member-uni">${searchInstance.type.name}</div>
        <g:checkBox name="memberchecked" id="${searchInstance.id}" value="${true}" />
      </div>

    </div>
  </g:each>
  <div class="spacer"></div>

  <script type="text/javascript">

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

  <g:submitButton onclick="kontrolle();" name="button" value="${message(code:'add')}"/>
  <div class="spacer"></div>

</g:if>
<g:else>
  <span class="italic">Keine Treffer!</span>
</g:else>