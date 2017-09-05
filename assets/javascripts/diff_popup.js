/*difftest*/
$(function () {
  $("#history div.journal ul > li > a").attr("onclick", "return false;").on("click", function () {
    var diffUrl = $(this).attr("href");
    var clickNoteId = $(this).parents("div.journal:first").find("h4 > a.journal-link").text();
    var dlgName = "#diffpopup" + clickNoteId.split("#")[1];
    if ($(dlgName).size() == 1)
    {
      $(dlgName).dialog("moveToTop");
      return;
    }
    $.get(diffUrl, { noteId: clickNoteId }, function (data) {
      var noteName = decodeURIComponent(this.url.split("?")[1].split("&")[1].split("=")[1]);
      var popupId = "diffpopup" + noteName.split("#")[1];
      $("#content").append("<div id='" + popupId + "'></div>");
      $("#" + popupId).html($("#content", data).html()).find("h2, p:nth-child(4) > a").remove().end().dialog({
        title: noteName,
        width: window.innerWidth / 2 - 20,
        maxHeight: window.innerHeight - 40,
        position: { my: "center center", at: "right center", of: window },
        open: function () {
          popupOffset = $("#" + popupId).offset();
        },
        close: function (event) {
          $(this).dialog('destroy');
          $(event.target).remove();
        }
      }).show();
    });
  });
});
