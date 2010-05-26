<%--
  User: mkuhl
  Date: 27.09.2009
  Time: 09:44:19

  template to render the picture box component of a profile
  model consists of $name, $type, $imageUrl (may be ommitted for default "picturebox behaviour
--%>

<%
  def boxclass = "picture-box"
  if (type)
    boxclass += "-${type}"
%>

<div class="${boxclass}">
  <table width="250" align="center">
    <tr><th class="rang"><h1>${name}</h1></th></tr>
    <tr><td class="profile-pic"><img src="${g.resource(dir:'images/avatar', file:imageUrl)}" width="150" height="150" alt="picture"/></td></tr>
  </table>
</div>
