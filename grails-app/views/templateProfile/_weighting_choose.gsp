<g:hiddenField id="lower${dropdown}${i}" name="method${dropdown}lower" value="0"/>
<g:hiddenField id="upper${dropdown}${i}" name="method${dropdown}upper" value="0"/>
<span style="cursor: pointer;" id="lowerstars${dropdown}${i}" onclick="toggleStars('lower', ${dropdown}, ${i})"></span> bis <span style="cursor: pointer;" id="upperstars${dropdown}${i}" onclick="toggleStars('upper', ${dropdown}, ${i})"></span> <g:remoteLink controller="templateProfile" action="weightingAll" update="element_weighting_${dropdown}_${i}" params="[i: i, dropdown: dropdown]">(<g:message code="define_orAny"/>)</g:remoteLink>

<script type="text/javascript">
    var star = "<img src='${resource(dir: 'images/icons', file: 'icon_star.png')}' />";
    var starempty = "<img src='${resource(dir: 'images/icons', file: 'icon_star_empty.png')}' />";

    updateStars('lower', ${dropdown}, ${i}, 0);
    updateStars('upper', ${dropdown}, ${i}, 0);

    function toggleStars(stars, dropdown, i) {
        var starsValue = $('#' + stars + dropdown + i).val();
        starsValue++;
        if (starsValue == 3)
            starsValue = 0;

        $('#' + stars + dropdown + i).val(starsValue);
        updateStars(stars, dropdown, i, starsValue);

        // check upper value, if it is smaller than lower value, increase it
        if (stars == "lower") {
            var upperValue = $('#upper' + dropdown + i).val();
            if (upperValue < starsValue) {
                upperValue++;
                $('#upper' + dropdown + i).val(upperValue);
                updateStars("upper", dropdown, i, upperValue);
            }
        }
        // check lower value, if it is higher than upper value, decrease it
        if (stars == "upper") {
            var lowerValue = $('#lower' + dropdown + i).val();
            if (lowerValue > starsValue) {
                lowerValue = 0;
                $('#lower' + dropdown + i).val(lowerValue);
                updateStars("lower", dropdown, i, lowerValue);
            }
        }
    }

    function updateStars(stars, dropdown, i, starsValue) {
        var starsElement = $('#' + stars + 'stars' + dropdown + i);
        starsElement.html("");
        if (starsValue > 0)
            starsElement.append(star);
        else
            starsElement.append(starempty);

        if (starsValue > 1)
            starsElement.append(star);
        else
            starsElement.append(starempty);
    }

</script>