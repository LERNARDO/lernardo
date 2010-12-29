<div id="comments">
<g:if test="${!commented.profile.comments}">
  <g:message code="comment.noComments"/>
</g:if>
<g:else>
  <g:each in="${commented.profile.comments}" var="comment" status="i">

    <div class="comment" id="comment${i}">
      <g:render template="/comment/comment" model="[i:i, comment: comment, commented: commented, currentEntity: currentEntity]"/>
    </div>

  </g:each>
</g:else>
</div>
