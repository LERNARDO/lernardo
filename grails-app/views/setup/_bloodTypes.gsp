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

<g:if test="${setupInstance.bloodTypes}">
  <ul>
    <g:each in="${setupInstance.bloodTypes}" var="bloodType" status="i">
      <li class="fader" id="bt${i}"><g:render template="bloodType" model="[setupInstance: setupInstance, bloodType: bloodType, i: i]"/></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <span class="italic red"><g:message code="bloodTypes.empty"/></span>
</g:else>