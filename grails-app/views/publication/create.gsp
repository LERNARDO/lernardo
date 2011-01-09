<%@ page import="at.uenterprise.erp.PublicationType" %>
<head>
  <meta name="layout" content="private"/>
  <title><g:message code="publication.profile.create"/></title>
</head>
<body>
<div class="boxHeader">
  <div class="second">
    <h1><g:message code="publication.profile.create"/></h1>
  </div>
</div>
<div class="boxGray">
  <div class="second">

      <g:hasErrors bean="${publication}">
        <div class="errors">
          <g:renderErrors bean="${publication}" as="list"/>
        </div>
      </g:hasErrors>

      <g:uploadForm action="save" id="${entity.id}">

        <div class="text-field">
          <label for="name"><g:message code="publication.profile.name"/>:</label><br />
          <g:textField class="${hasErrors(bean: publication, field: 'name', 'errors')} countable${publication.constraints.name.maxSize}" id="name" name="name" size="60" value="${fieldValue(bean:publication,field:'name')}"/>
        </div>

        %{-- 06.08.2010: disabled for now --}%
        %{--<div>
          <label for="category"><g:message code="publication.profile.category"/>:</label><br />
          <g:select id="category" name="type.id" value="${publication?.type?.id}"
            from="${PublicationType.list()}"
            optionKey="id"
            optionValue="name"
            noSelection="${['null': message(code:'publication.profile.categoryEmpty')]}">
          </g:select>
        </div>--}%

        %{-- TODO: uncomment when implemented
        <div>
          <br/>
          <label for="category"><g:message code="publication.profile.share"/>:</label><br />
          <g:select name="accesslevel"
            from="${[0:'Alle',1:'Netzwerk & Freunde',2:'nur Freunde',3:'Privat']}"
            optionKey="key"
            optionValue="value"
            noSelection="${['null': message(code:'publication.profile.categoryEmpty')]}">
          </g:select>
        </div>--}%

        <div class="file-field">
          <label for="file"><g:message code="publication.profile.file"/>:</label><br />
          <input size="50" id="file" type="file" name="file"/>
        </div>

        <div class="bottom-buttons">
          <g:submitButton name="update" value="${message(code:'save')}"/>
          <g:link class="buttonGray" controller="publication" action="profile" id="${entity.id}"><g:message code="cancel"/></g:link>
          <div class="spacer"></div>
        </div>

      </g:uploadForm>
    </div>
  </div>
</body>
