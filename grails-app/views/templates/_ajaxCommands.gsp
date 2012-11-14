<g:if test="${ajax == 'appointments'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "appointmentProfile", action: "index", update: "content")}
        });
    </script>
</g:if>