<script type="text/javascript">
    $(document).ready(function() {
        $(".datepicker").datepicker({
            monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
                '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
                '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
                '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
            dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
                '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
                '${message(code: "saturday.short")}'],
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd. mm. yy',
            minDate: new Date(1900, 1, 1),
            firstDay: 1,
            yearRange: 'c-20:c+20',
            autoSize: true});
    });
</script>

<h4><g:message code="evaluation.create"/></h4>

<div class="boxContent">

    <g:hasErrors bean="${evaluationInstance}">
      <div class="errors">
        <g:renderErrors bean="${evaluationInstance}" as="list"/>
      </div>
    </g:hasErrors>

    <div class="graypanel">
      <div id="select-box">
        <p><g:message code="evaluation.linkToActivity"/></p>
        <g:formRemote name="formRemote" update="results" url="[controller: 'evaluation', action: 'searchMe']" before="showspinner('#results')">
          <g:textField class="datepicker" name="myDate" value=""/>
          <g:submitButton name="submit" value="OK"/>
        </g:formRemote>
      </div>

      <div id="results"></div>
      <div id="selected" style="padding-top: 5px;"></div>
    </div>

    <g:formRemote name="formRemote" url="[action: 'save', id: entity.id]" update="content">

      %{--<p class="gray">
        <g:message code="linkedTo"/><br/>
        <g:if test="${target}">
          <g:select name="linkedentity" id="hiddenselect" from="[target]" optionKey="id" optionValue="profile" value="${target?.id}"/>
        </g:if>
        <g:else>
          <g:select name="linkedentity" id="hiddenselect" from="[]"/>
        </g:else>
      </p>--}%

      <g:hiddenField name="linkedentity" id="hiddenEntityId" value="${target?.id}"/>

      <g:if test="${target}">
          <p>
            <g:message code="linkedTo"/>: <erp:createLinkFromEvaluation linked="${target}"/>
          </p>
      </g:if>
      %{--<g:else>
          <span class="italic"><g:message code="links.notLinked"/></span>
      </g:else>--}%

      <p class="prop">
        <span class="name"><g:message code="title"/>: </span>
        <span class="value">
          <g:textField class="${hasErrors(bean: evaluationInstance, field: 'title', 'errors')}" size="60" name="title" value="${fieldValue(bean: evaluationInstance, field: 'title').decodeHTML()}"/>
        </span>
      </p>

      <p class="gray"><g:message code="description"/><br/>
        <span class="${hasErrors(bean: evaluationInstance, field: 'description', 'errors')}">
          <ckeditor:editor name="description" height="200px" toolbar="Basic" removeInstance="true">
            ${fieldValue(bean:evaluationInstance,field:'description').decodeHTML()}
          </ckeditor:editor>
        </span>
      </p>

      <p class="gray"><g:message code="action"/><br/>
        <span class="${hasErrors(bean: evaluationInstance, field: 'method', 'errors')}">
          <ckeditor:editor name="method" height="200px" toolbar="Basic" removeInstance="true">
            ${fieldValue(bean:evaluationInstance,field:'method').decodeHTML()}
          </ckeditor:editor>
        </span>
      </p>

      <div class="buttons cleared">
        <div class="button"><g:submitButton name="submitButton" class="buttonGreen" onclick="for ( instance in CKEDITOR.instances )
        CKEDITOR.instances[instance].updateElement(); CKEDITOR.instances[instance].setData('');" value="${message(code:'save')}"/></div>
        <g:link controller="${entity.type.supertype.name + 'Profile'}" class="buttonGray" action="show" id="${entity.id}" params="[ajax: 'evaluations', ajaxId: entity.id]"><g:message code="cancel"/></g:link>
      </div>

    </g:formRemote>

</div>
