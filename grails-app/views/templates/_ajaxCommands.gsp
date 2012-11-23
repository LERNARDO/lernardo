<g:if test="${ajax == 'appointments'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "appointmentProfile", action: "index", update: "content")}
        });
    </script>
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