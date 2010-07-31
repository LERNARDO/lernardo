<g:if test="${allTemplates}">

  <g:each in="${allTemplates}" var="searchInstance">
    <g:checkBox name="memberchecked" id="${searchInstance.id}" value="${true}" /> <g:link controller="templateProfile" action="show" id="${searchInstance.id}">${searchInstance.profile.fullName}</g:link><br/>
  </g:each>
  <div class="spacer"></div>

  <script type="text/javascript">

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

  <g:submitButton onclick="kontrolle();" name="button" value="${message(code:'add')}"/>
  <div class="spacer"></div>

</g:if>
<g:else>
  <span class="italic">Keine Treffer!</span>
</g:else>