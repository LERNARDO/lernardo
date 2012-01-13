<erp:renderLogMonth logMonth="${logMonth}" facility="${facility}" date="${date}"/>

<p style="margin-top: 10px;">
  <g:link action="createpdf" id="${logMonth.id}" params="[facility: facility.id, date: formatDate(date: date, format: 'dd. MM. yyyy')]"><img src="${g.resource(dir:'images/icons', file:'icon_pdf.png')}" alt="PDF" align="top"/> PDF</g:link>
</p>