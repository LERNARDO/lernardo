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

  <span class="member-name"><g:link class="largetooltip" data-idd="${entity.id}" controller="${entity.type.supertype.name + 'Profile'}" action="show" id="${entity.id}">${entity.profile.fullName.decodeHTML()}</g:link></span><br/>
  <span class="member-type"><g:message code="${entity.type.supertype.name}"/></span><br/>
  <span class="member-other">
      <g:if test="${entity.type.name == 'Betreutengruppe'}">
        <a href="#" onclick="jQuery('#modal${i}').modal(); return false"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" style="position: relative; top: 4px;"/></a> <g:link controller="excel" action="report" id="${entity.id}" params="[type: 'clientgroup']"><img src="${g.resource(dir:'images/icons', file:'icon_xls.png')}" alt="XLS" style="position: relative; top: 4px;"/></g:link>
        <div id="modal${i}" style="display: none;">
            <g:form action="createpdf" id="${entity.id}">
                <g:radioGroup name="pageformat" labels="['DIN A4 Hoch (210mm × 297mm)','DIN A4 Quer (297mm × 210mm)','Letter Hoch (216mm × 279mm)','Letter Quer (279mm × 216mm)']" values="[1,2,3,4]" value="1">
                    <p>${it.radio} ${it.label}</p>
                </g:radioGroup>
                <g:submitButton name="pdfbutton" value="${message(code: 'notification.send')}"/>
            </g:form>
        </div>
      </g:if>
      <g:if test="${entity.type.name == 'Projekt'}">
          <g:if test="${entity.profile.completed}">
              <div class="member-type"><span class="green"><g:message code="project.completed"/></span></div>
          </g:if>
      </g:if>
  </span>

</div>