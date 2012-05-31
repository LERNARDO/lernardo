<g:form style="float: right; margin-right: 5px;" name="searchForm" controller="search">
  <g:textField class="search" name="search" size="30" placeholder="${message(code: 'searchWord')}"/>
  <span class="searchButton"><g:submitButton name="searchButton" class="buttonBlue" value="${message(code: 'search')}"/></span>
</g:form>