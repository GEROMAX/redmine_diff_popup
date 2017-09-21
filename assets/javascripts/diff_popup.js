function replaceJournalDiff()
{
  $("#history div.journal ul > li > a").each(function(){
    //find li
    var orgDiff = $(this).parent();
    var popDiff = $(this).parents("div.journal:first").next("li");

    //replace and set func
    popDiff.replaceAll(orgDiff).find("a").on("click", function(){
      var diffUrl = $(this).attr("href");
      var journalIndice = diffUrl.split("&indice=")[1];
      var dlgName = "#diffpopup" + journalIndice;
      
      //on top dialog
      if ($(dlgName).size() == 1)
      {
        $(dlgName).dialog("moveToTop");
        return;
      }
      
      //show dialog
      $.get(diffUrl, function (data) {
        var journalIndice = decodeURIComponent(this.url.split("?")[1].split("&indice=")[1]);
        var popupId = "diffpopup" + journalIndice;
        $("#content").append("<div id='" + popupId + "'></div>");
        $("#" + popupId).html(data).dialog({
          title: "#" + journalIndice,
          width: window.innerWidth / 2 - 40,
          maxHeight: window.innerHeight - 160,
          position: { my: "center center", at: "right center", of: window },
          create: function(event) {
            $(event.target).dialog("widget").css({ "position": "fixed" });
          },
          open: function() {
            $(this).find("a").blur();
          },
          close: function (event) {
            $(this).dialog("destroy");
            $(event.target).remove();
          }
        }).show();
      });
    });
  });
}
