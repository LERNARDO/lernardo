<%
    def valuelower = 0
    def valueupper = 2
    if (params.method1 || params.method2 || params.method3) {
        if (dropdown == "1") {
            valuelower = params.method1lower[i].toInteger()
            valueupper = params.method1upper[i].toInteger()
        }
        else if (dropdown == "2") {
            valuelower = params.method2lower[i].toInteger()
            valueupper = params.method2upper[i].toInteger()
        }
        else {
            valuelower = params.method3lower[i].toInteger()
            valueupper = params.method3upper[i].toInteger()
        }
    }
%>

<g:hiddenField id="lower${dropdown}${i}" name="method${dropdown}lower" value="${valuelower}"/>
<g:hiddenField id="upper${dropdown}${i}" name="method${dropdown}upper" value="${valueupper}"/>
<span style="cursor: pointer;" id="lowerstars${dropdown}${i}" onclick="toggleStars('lower', ${dropdown}, ${i})"></span> bis <span style="cursor: pointer;" id="upperstars${dropdown}${i}" onclick="toggleStars('upper', ${dropdown}, ${i})"></span>

<script type="text/javascript">
    var star = "<img src='${resource(dir: 'images/icons', file: 'icon_star.png')}' />";
    var starempty = "<img src='${resource(dir: 'images/icons', file: 'icon_star_empty.png')}' />";

    updateStars('lower', ${dropdown}, ${i}, ${valuelower});
    updateStars('upper', ${dropdown}, ${i}, ${valueupper});

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