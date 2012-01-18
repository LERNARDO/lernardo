  <script type="text/javascript">

  function kontrolle1(id) {
    var textfield = document.getElementById("hiddentextfield1");
    textfield.value = id;
  }

  </script>

  <script type="text/javascript">

    function checkIt(id, name) {
      var select = document.getElementById("hiddenselect");

      select.options.length = 0;

      var optn = document.createElement("OPTION");
      optn.text = name;
      optn.value = id;
      optn.selected = true;
      select.options.add(optn);
    }

  </script>

<g:if test="${results}">
  <div class="remoteresults">
    <g:each in="${results}" var="entity">
      <g:remoteLink url="[controller:'evaluation', action:'addResult', id: entity.id]" update="selected" before="checkIt('${entity.id}','${entity.profile.fullName}');">
      <div class="remoteresult">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;">
              <span class="bold" style="color: #000">${entity.profile.fullName}</span><br/>
              <g:message code="${entity.type.supertype.name}"/><br/>
              <g:if test="${entity.type.supertype.name == 'projectUnit'}">
                <erp:getProjectOfUnit unit="${entity}"/>
              </g:if>
            </td>
          </tr>
        </table>
      </div>
      </g:remoteLink>
    </g:each>
  </div>
</g:if>