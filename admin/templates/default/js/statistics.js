function showDatepick(e){return $(e).hasClass("activated")?($("#pickspan").hide(),$(e).removeClass("activated").addClass("menul").prevAll(".menuitm").show()):($("#pickspan").show(),$(e).addClass("activated").removeClass("menul").prevAll(".menuitm").hide()),!1}function submitdate(act){var date=$("#daterange").val(),month=$("#daterangem").val();if(month){var week=$("#daterangew").val(),dept=$("#datedept").val();month=(parseInt(month)+1).toString(),1==month.length&&(month="0"+month),month+="&range=month",week&&(month+="&week="+week),dept&&(month+="&dept="+dept)}else month="";return date&&(window.location="?cmd=stats&action="+act+"&from="+date+month),!1}