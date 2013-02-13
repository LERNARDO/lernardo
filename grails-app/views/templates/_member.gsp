<script type="text/javascript">
  $(document).ready(function() {
    $('.largetooltip').each(function() {
      $(this).qtip({
        content: {
          text: 'Loading...',
          ajax: {
            url: '${grailsApplication.config.grails.serverURL}/profile/getTooltip',
            type: 'GET',
            data: {id : $(this).attr('data-idd')}
          }
        },
          position: {
              my: 'bottom left',
              at: 'top right',
              target: 'mouse' //$(this)
          },
        show: {
          delay: 1000
        }
      });
    });
  });
</script>

<div class="member">

  <div>
      <div class="member-favpreview"><erp:getSimpleFavorite entity="${entity}"/></div>
      <div class="member-image">
          <g:link class="largetooltip" data-idd="${entity.id}" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">
            <erp:profileImage entity="${entity}" width="50" height="50" align="left"/>
          </g:link>
      </div>
  </div>

  <span class="member-name"><g:link class="largetooltip" data-idd="${entity.id}" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">${entity.profile.decodeHTML()}</g:link></span><br/>
  <span class="member-type"><g:message code="${entity.type.supertype.name}"/></span><br/>
  <span class="member-other">
      <erp:createdBy entity="${entity}">
        <g:message code="creator"/>: ${creator.profile}<br/>
      </erp:createdBy>
      <g:if test="${entity.type.name == 'Betreutengruppe'}">
        <a href="#" onclick="jQuery('#modal${i}').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" style="position: relative; top: 4px;"/></a> <g:link controller="excel" action="report" id="${entity.id}" params="[type: 'clientgroup']"><img src="${g.resource(dir:'images/icons', file:'icon_xls.png')}" alt="XLS" style="position: relative; top: 4px;"/></g:link>
        <div id="modal${i}" style="display: none;">
            <g:form action="createpdf" id="${entity.id}">
                <g:render template="/templates/printRadioGroup"/>
                <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
            </g:form>
        </div>
      </g:if>
      <g:if test="${entity.type.name == 'Projekt'}">
          <g:if test="${entity.profile.completed}">
              <div class="member-type"><span class="green"><g:message code="project.completed"/></span></div>
          </g:if>
      </g:if>
      <g:if test="${entity.type.name == 'Partner'}">
          <a href="#" onclick="jQuery('#modal${i}').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" style="position: relative; top: 4px;"/></a>
          <div id="modal${i}" style="display: none;">
              <g:form action="createpdf" id="${entity.id}">
                  <g:render template="/templates/printRadioGroup"/>
                  <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
              </g:form>
          </div>
      </g:if>
  </span>

</div>