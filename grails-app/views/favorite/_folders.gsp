<script type="text/javascript">
  $(document).ready(function() {
    $(".fader").hover(
        function () {
          $(this).find("span").eq(1).css("visibility", "visible");
        },
        function () {
          $(this).find("span").eq(1).css("visibility", "hidden");
        }
    );
  });
</script>

<erp:showFolders/>