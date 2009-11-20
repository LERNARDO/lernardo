<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<html>
  <head>
    <title><g:layoutTitle default="Lernardo" /></title>
    <link rel="stylesheet" href="${g.resource (dir:'css', file:'yui-reset-fonts-grids.css')}" type="text/css">
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'layout.css')}" type="text/css" media="screen" charset="utf-8">
    <link rel="icon" href="${createLinkTo(dir:'images',file:'favicon.jpg')}" type="image/jpg" />
    <g:layoutHead />
    <g:javascript library="jquery"/>
  </head>
  <body>
    <div id="private">
      <div id="doc4">
        <div id="hd">
          <g:render template="/templates/header" />
          <div id="nav">
            <g:render template="/templates/navigation" />
          </div>
        </div>
        <div id="banner">
          <ol class="imgmenu">
            <li>
              <div id="member" class="imgbox">
                <g:link controller="profile" action="show" params="[name:currentEntity.name]">
                  <img src="${g.resource(dir:'images/iconex', file:'profile.png')}" alt="Profile" />
                  <h3>Mein Profil</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="paeds" class="imgbox">
                <g:link controller="template" action="list">
                  <img src="${g.resource(dir:'images/iconex', file:'activities.png')}" alt="Aktivität planen" />
                  <h3>Aktivität planen</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="activities" class="imgbox">
                <g:link controller="activity" action="list">
                  <img src="${g.resource(dir:'images/iconex', file:'all_activities.png')}" alt="Aktivitäten" />
                  <h3>Aktivitäten</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="orga" class="imgbox">
                <g:link controller="calendar" action="showall">
                  <img src="${g.resource(dir:'images/iconex', file:'calendar.png')}" alt="Kalender" />
                  <h3>Kalender</h3>
                </g:link>
              </div>
            </li>

            <li>
              <div id="profiles" class="imgbox">
                <g:link controller="profile" action="search">
                  <img src="${g.resource(dir:'images/iconex', file:'profiles.png')}" alt="Suche" />
                  <h3>Suche</h3>
                </g:link>
              </div>
            </li>

            <ub:isAdmin entityName="${currentEntity.name}">
            <li>
              <div id="admin" class="imgbox">
                <g:link controller="admin" action="index">
                  <img src="${g.resource(dir:'images/iconex', file:'admin.png')}" alt="Admin" />
                  <h3>Admin</h3>
                </g:link>
              </div>
            </li>
            </ub:isAdmin>
          </ol>
        </div>

        <div id="bd">
          <g:layoutBody />
        </div>

        <div id="ft">
          <g:render template="/templates/footer" />
        </div>
      </div><!-- doc4 -->
    </div><!-- private -->
  </body>
</html>