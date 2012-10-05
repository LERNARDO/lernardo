<table style="background: #eee;">
  <tr>
    <td style="padding: 5px;">
      <erp:profileImage entity="${entity}" width="30" height="30"/>
    </td>
    <td style="padding: 5px;">
      ${entity.profile.decodeHTML()}
    </td>
  </tr>
</table>