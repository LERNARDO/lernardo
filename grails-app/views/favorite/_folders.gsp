<script type="text/javascript">
  $(document).ready(function() {
    $(".fader").hover(
        function () {
          $(this).find("span").css("visibility", "visible");
        },
        function () {
          $(this).find("span").css("visibility", "hidden");
        }
    );
  });
</script>

<erp:showFolders/>