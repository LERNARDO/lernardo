<erp:accessCheck types="['Betreiber','Pädagoge']">
  <div class="buttons cleared">
    <g:form controller="news" action="create">
      <div class="button"><g:submitButton name="submit" class="buttonGreen" value="${message(code: 'object.create', args: [message(code: 'news')])}"/></div>
    </g:form>
  </div>
</erp:accessCheck>

<div id="news-container">
  <g:render template="/news/newsitems" model="[news: news]"/>
</div>

<div class="paginateButtons">
  <util:remotePaginate action="remoteNews" total="${totalNews}" update="news" next="${message(code:'page.next')}" prev="${message(code:'page.prev')}"/>
</div>