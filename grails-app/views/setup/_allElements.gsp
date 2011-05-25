<script type="text/javascript">
  $(document).ready(function() {
    $(".fader").hover(
      function () {
        $(this).find("span").css("visibility", "visible");
      },
      function () {
        $(this).find("span").css("visibility", "hidden");
      }
    );
  });
</script>

<g:if test="${setupInstance[type]}">
  <ul>
    <g:each in="${setupInstance[type]}" var="element" status="i">
      <li class="fader" id="${type + 'element' + i}"><g:render template="element" model="[setupInstance: setupInstance, element: element, type: type, toUpdate: toUpdate, i: i]"/></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="${type}.empty"/></span>
</g:else>