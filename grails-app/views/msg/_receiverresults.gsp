  <script type="text/javascript">

  function checkIt(id, name) {
    var select = document.getElementById("hiddenselect");

    var clean = true;
    for (var i = 0; i < select.options.length; i++) {
        if (select.options[i].value == id) {
            clean = false;
            break
        }
    }

    if (clean) {
        var optn = document.createElement("OPTION");
        optn.text = name;
        optn.value = id;
        optn.selected = true;
        select.options.add(optn);
    }
  }

  </script>

<g:if test="${results}">
  <div class="remoteresults" style="width: 535px">
    <g:each in="${results}" var="entity">
      <div class="remoteresult" onclick="checkIt('${entity.id}','${entity.profile}');">
        <table>
          <tr>
            <td><erp:profileImage entity="${entity}" width="65" height="65"/></td>
            <td style="vertical-align: top; padding-left: 5px;"><span class="bold" style="color: #000">${entity.profile}</span></td>
          </tr>
        </table>
      </div>
    </g:each>
  </div>
</g:if>