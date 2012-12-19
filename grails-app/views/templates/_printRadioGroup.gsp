<g:radioGroup name="pageformat" labels="['DIN A4 ' + message(code: 'print_portrait') + ' (210mm × 297mm)','DIN A4 ' + message(code: 'print_landscape') + ' (297mm × 210mm)','Letter ' + message(code: 'print_portrait') + ' (216mm × 279mm)','Letter ' + message(code: 'print_landscape') + ' (279mm × 216mm)']" values="[1,2,3,4]" value="1">
    <p>${it.radio} ${it.label}</p>
</g:radioGroup>