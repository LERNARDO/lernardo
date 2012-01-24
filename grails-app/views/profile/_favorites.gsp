<%@ page import="at.openfactory.ep.Entity" %>
<g:if test="${entity.profile.favorites}">
  <ul>
    <g:each in="${entity.profile.favorites}" var="fav">
      <g:set var="favorite" value="${Entity.get(fav.toInteger())}"/>
      <li class="icon-star"><g:link controller="${favorite.type.supertype.name +'Profile'}" action="show" id="${favorite.id}" params="[entity:favorite.id]">${favorite.profile.fullName}</g:link></li>
    </g:each>
  </ul>
</g:if>
<g:else>
  <ul>
    <li class="icon-start italic"><g:message code="favorites.noneYet"/></li>
  </ul>
</g:else>