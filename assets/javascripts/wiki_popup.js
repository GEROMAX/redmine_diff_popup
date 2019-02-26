function replaceWikiSubmitButton()
{
  $("button.wiki-popup, #project_id, #id").replaceAll($("#content > form > p > input[type='submit']")).filter("button.wiki-popup").show().on("click", function(){
    //on top dialog
    var dlgName = "#diffpopup" + $("input[name='version_from']:checked").val() + "_" + $("input[name='version']:checked").val();
    if ($(dlgName).size() == 1)
    {
      $(dlgName).dialog("moveToTop");
      return false;
    }
    
    //show dialog
    var diffUrl = $(this).attr("url") + $(this).parent("form").serialize();
    $.get(diffUrl, function (data) {
      var params = q_to_hash(decodeURIComponent(this.url).split("?")[1].split("&"));
      var popupId = "diffpopup" + params["version_from"] + "_" + params["version"];
      $("#content").append("<div id='" + popupId + "'></div>");
      $("#" + popupId).html(data).dialog({
        title: $("#" + popupId).find("p.wiki-popup-title").text(),
        width: window.innerWidth / 2 - 40,
        maxHeight: window.innerHeight - 160,
        position: { my: "center center", at: "right center", of: window },
        create: function(event) {
          $(event.target).dialog("widget").css({ "position": "fixed" });
        },
        open: function() {
          $(this).find("a").blur();
        },
        resizeStart: function(event) {
          $(event.target).dialog("option", "maxHeight", "");
        },
        close: function (event) {
          $(this).dialog("destroy");
          $(event.target).remove();
        }
      }).show();
    });

    return false;
  });
}

function q_to_hash(param){
  var hs = new Object;
  for(var i=0;i < param.length;i++) {
    var kv = param[i].split("=");
    hs[kv[0]]=kv[1];
  }
  return hs;
}