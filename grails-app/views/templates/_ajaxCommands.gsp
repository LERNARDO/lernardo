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
<g:if test="${ajax == 'evaluations'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "evaluation", action: "list", id: ajaxId, update: "content")}
        });
    </script>
</g:if>
<g:if test="${ajax == 'showevaluation'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "evaluation", action: "show", id: ajaxId, update: "content")}
        });
    </script>
</g:if>
<g:if test="${ajax == 'createevaluation'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "evaluation", action: "create", id: id, params: [target: ajaxId], update: "content")}
        });
    </script>
</g:if>
<g:if test="${ajax == 'changePicture'}">
    <script type="text/javascript">
        $(function() {
            ${remoteFunction(controller: "profile", action: "uploadProfileImage", id: ajaxId, update: "content")}
        });
    </script>
</g:if>