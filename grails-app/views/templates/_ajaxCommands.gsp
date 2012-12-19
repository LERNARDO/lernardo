<g:if test="${ajax == 'appointments'}">
    <g:if test="${ajaxId != 0}">
        <script type="text/javascript">
            $(function() {
                ${remoteFunction(controller: "appointmentProfile", action: "show", id: ajaxId, update: "content")}
            });
        </script>
    </g:if>
    <g:else>
        <script type="text/javascript">
            $(function() {
                ${remoteFunction(controller: "appointmentProfile", action: "index", update: "content")}
            });
        </script>
    </g:else>
</g:if>
<g:if test="${ajax == 'publications'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "publication", action: "list", update: "content")}
        });
    </script>
</g:if>
<g:if test="${ajax == 'messages'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "msg", action: "inbox", update: "content")}
        });
    </script>
</g:if>