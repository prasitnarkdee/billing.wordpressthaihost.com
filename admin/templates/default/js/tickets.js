function reset_bulk(){$(".bottom-fixed .tag-form input, .bottom-fixed input, .bottom-fixed textarea").each(function(){$(this).is('[type="checkbox"]')?$(this).attr("checked",!1):$(this).val("").filter("textarea").text("").hide()}),$(".bottom-fixed .tag-form .tag").remove(),$(".hasMenu span").text(lang.nochange).eq(0).text(lang.none)}function showhide_bulk(){setTimeout(function(){0==$("#testform input.check:checked").length?$(".bottom-fixed").slideUp("fast",reset_bulk):$(".bottom-fixed").slideDown()},100)}function dropdown_handler(a,o,p,h){o.children("span").text(h).end().children("input").val(a),o.is("#bulk_macro")&&$.get("?cmd=predefinied&action=getmacro&id="+a,function(resp){if(void 0!=resp.macro.errors);else for(var key in resp.macro)switch(key){case"reply":null!=resp.macro[key]&&resp.macro[key].length&&($('input[name="bulk_reply"]').attr("checked","checked").prop("checked",!0),$('textarea[name="bulk_message"]').slideDown().val(resp.macro[key]));break;case"tags":if(null!=resp.macro[key]&&void 0!=ticket&&"function"==typeof ticket.insertTags)for(var i=0;i<resp.macro.tags.length;i++){var ev=jQuery.Event("keyup");ev.which=13,$("input#tagsin").val(resp.macro.tags[i]).trigger(ev).val("").next("ul").hide()}break;case"status":null!=resp.macro[key]&&$("#bulk_"+key+"_m").length&&dropdown_handler(resp.macro[key],$("#bulk_"+key),{},$("#bulk_"+key+"_m").find('a[href="'+resp.macro[key]+'"]').html());break;case"deptid":null!=resp.macro[key]&&$("#bulk_dept_m").length&&dropdown_handler(resp.macro[key],$("#bulk_dept"),{},$("#bulk_dept_m").find('a[href="'+resp.macro[key]+'"]').html());break;default:null!=resp.macro[key]&&$("#bulk_"+key+"_m").length&&dropdown_handler(resp.macro[key],$("#bulk_"+key),{},$("#bulk_"+key+"_m").find('a[href="'+resp.macro[key]+'"]').html())}})}$(document).on("HostBill.ticketload",function(ev,number,id){$("#LeaveNotes").on("click",function(){var self=$(this);return self.is(".active")?(self.removeClass("active"),$("#ticketnotebox").slideUp("fast")):(self.addClass("active"),$("#ticketnotebox").slideDown("fast"),$("#ticketnotesarea").focus(),$("html, body").stop().animate({scrollTop:$("#ticketnotesarea").offset().top-5},"fast")),!1}),$("#replyarea").on("keyup",function(){var len=$(this).val().length;1!==len&&0!==len||(ticket.poll(ticket.autopoll),$("input[name=save_draft]").val(!len))}),$("#timeTracking").on("click",function(){var self=$(this);return self.is(".active")?(self.removeClass("active"),$("#ticketbils").slideUp("fast")):(self.addClass("active"),ticket.getBilling(),$("#ticketbils").slideDown("fast"),$("html, body").stop().animate({scrollTop:$("#ticketbils").offset().top-5},"fast")),!1}),$("#ticketTimers").on("click",function(){var self=$(this);return self.is(".active")?(self.removeClass("active"),$("#ticketTimersBox").slideUp("fast")):(self.addClass("active"),ticket.getTimers(),$("#ticketTimersBox").slideDown("fast"),$("html, body").stop().animate({scrollTop:$("#ticketTimersBox").offset().top-5},"fast")),!1}),$("#QueuedInvoiceItems").on("click",function(){var self=$(this);return self.is(".active")?(self.removeClass("active"),$("#QueuedInvoiceItemsBox").slideUp("fast")):(self.addClass("active"),ticket.getQueuedInvoiceItems(),$("#QueuedInvoiceItemsBox").slideDown("fast"),$("html, body").stop().animate({scrollTop:$("#QueuedInvoiceItemsBox").offset().top-5},"fast")),!1}),$(".t-w-modal a").on("click",function(){var self=$(this),form=self.parent().find("input, select");if(!form.length)return!1;var callback=function(result,item){if(form.val(""),self.removeClass("btn-success btn-danger btn-info btn-warning").find("span").remove(),result){var bclass="btn-success";"select"==options.inputType&&(bclass="Closed"==result?"btn-danger":"Client-Reply"==result?"btn-warning":"btn-success"),form.val(result),self.addClass(bclass),self.append("<span>: <em>"+result+"</em></span>")}else if(options.value&&"select"==options.inputType)return callback(options.value)},options={title:self.data("content"),value:form.val(),size:"small",callback:callback};return form.is("select")&&(options.inputType="select",options.inputOptions=[],form.children().each(function(){var opt=$(this);options.inputOptions.push({text:opt.text(),value:opt.val()})})),bootbox.prompt(options),!1}),$(document).on("calendar.listinit",function(){$(".ticket-calendar").show()}),$("#reply-form").on("submit",function(){return $("#ticketsubmitter").addClass("disabled").prop("disabled",!0).text("Sending.."),!0}),$(".pinned").click(function(){var ribd=$(this).attr("href").substr($(this).attr("href").lastIndexOf("/")+1),number=$("#ticket_number").val(),pinned=$(this).hasClass("pinned-active")?0:1,self=$(this);return $.post("?cmd=tickets&action=pinned_reply",{rid:ribd,number:number,pinned:pinned},function(){pinned?(self.addClass("pinned-active"),$("#reply_"+ribd).css("background","#f7fcff")):(self.removeClass("pinned-active"),$("#reply_"+ribd).css("background",""))}),!1}),$(".encryptreply").click(function(){var ribd=$(this).attr("href").substr($(this).attr("href").lastIndexOf("/")+1),number=$("#ticket_number").val(),self=$(this);return $.post("?cmd=tickets&action=encrypt_reply",{rid:ribd,number:number},function(){self.remove(),$("#reply_"+ribd).find(".reply-encrypted-message").show()}),!1}),$(".encryptmessage").click(function(){var number=$("#ticket_number").val(),self=$(this);return $.post("?cmd=tickets&action=encrypt_message",{number:number},function(){self.remove(),$(".ticket-encrypted-message").show()}),!1})}),$(document).on("click","[data-draft]",function(){var self=$(this),box=bootbox.alert({size:"medium",title:"Draft Reply by "+self.data("draft-by"),message:'<div class="text-center"><i class="fa fa-spin fa-spinner"></i> Loading...</div>'});return $.post("?cmd=tickets",{make:"loadreply",action:"menubutton",id:self.data("draft")},function(data){data.reply?$(".modal-body",box).html(data.reply.replace(/\n/g,"<br />")):$(".modal-body",box).html("")}),!1}),$(document).on("click",".remove-lock",function(){var self=$(this);$.post("?cmd=tickets",{make:"removereplylock",action:"menubutton",id:self.data("id")},function(data){data.result&&($("#replyarea").prop("disabled",!1),$(".remove-lock, .without-removing").hide())})}),$(document).on("click",".without-removing",function(){var id=$(this).data("id");$.post("?cmd=tickets",{make:"withoutremoving",action:"menubutton",id:id},function(data){data.md5&&($("#reply-form").append('<input type="hidden" name="lock" value="'+data.md5+'">'),$("#replyarea").prop("disabled",!1),$(".without-removing").hide())})}),$(document).on("click","#tagsBox span, .inlineTags span",function(){var tagstr=$('input[name="filter[tag]"]').val()||$(".fTag em").text(),tagin=$(this).text(),reg=new RegExp('((or|and|or not|and not|not) )* ?"'+tagin+'"',"ig");tagstr=tagstr.match(reg)?tagstr.replace(reg,""):tagstr+(tagstr.length?" or ":"")+'"'+tagin+'"',tagstr=tagstr.replace(/^\s*(and|or)\s*|\s*(and|or|not)\s*$/i,"");var fil=$('<input type="hidden" name="filter[tag]" value="">').val(tagstr);filter(fil)&&($("a.tload.selected").length>0?($("a.tload.selected").clone(!0).removeClass("tstyled").attr("href",$("a.tload.selected").attr("href")+"&filter[tag]="+tagstr).click(),$("#content_tb").addClass("searchon"),$(".freseter").css({display:"inline"})):$('<form action="?cmd=tickets" method="post">'+fil+"</form>").appendTo("body").submit()),$(".fTag em").text(tagstr).parent().show(),$('input[name="filter[tag]"]').val(tagstr)}),$(document).on("mousedown","a.freseter",function(){$(".fTag em").html("").parent().hide()}),$(document).on("HostBill.newticketform",function(){$("#clientfilter").click(function(){return $.facebox({ajax:"?cmd=tickets&action=clientfilter"}),!1})}),$(document).on("click",'.filterform input[type="submit"]:first',function(){$(this).parents("form")[0]["filter[tag]"].value&&$(".fTag em").text($(this).parents("form")[0]["filter[tag]"].value).parent().show()}),$(function(){$(".tstyled").click(function(){""==this.id||$("#list"+this.id).is(":visible")||($('.leftNav div[id^="listdept_"]').slideUp(),$("#list"+this.id).slideDown())}),$.post("?cmd=tickets",{action:"listtags"},function(data){ticket.updateTags(data.tags)})}),ticket={updteStat:function(data){$(".leftNav .msg_counter[id]").each(function(i){var that=$(this),id=that.attr("id").replace("ticketsn_",""),part=id.split("_");data[id]&&data[id].total&&"0"!=data[id].total?that.html("("+data[id].total+")").show():part.length>1&&data[part[1]]&&data[part[1]][part[0]]&&"0"!=data[part[1]][part[0]]?that.html("("+data[part[1]][part[0]]+")").show():that.hide()}),data.tags&&ticket.updateTags(data.tags)},loadBulkActions:function(){},zenMode:function(){"function"==typeof $.fn.textareafullscreen&&$("#replyarea").textareafullscreen({overlay:!0,maxWidth:"80%",maxHeight:"80%"})},showMatchingTags:function(list,str,max){var $list=$(list);$list.html("").hide(),void 0==max&&(max=10);var i=0,r=0,rbox=$(list);do{var spans=$("#tagsBox span.tag"+i++);spans.each(function(){var tag=this.innerHTML;(void 0==str||str.length<1||tag.match(new RegExp("^"+str+".*$")))&&0==$("span a:first-child",rbox.parent().parent()).filter(function(){return tag==$(this).text()}).length&&(0==max||r<max)&&(rbox.append("<li>"+this.innerHTML+"</li>"),r++)}),rm=!(max>0)||r<max}while(spans.length&&rm);$("li",$list).length&&$list.show();var validparents=$list.parents("#tagsCont, .tag-form, label.input");$("body").bind("mouseout mousein",function(e){0!=$(e.target).parents().filter(validparents).length||validparents.is(e.target)?(clearTimeout(ticket.hideTagsTimeout),ticket.hideTagsTimeout=null):null==ticket.hideTagsTimeout&&(ticket.hideTagsTimeout=setTimeout(function(){$(list).hide(),$("body").unbind("mouseout mousein")},400))})},hideTagsTimeout:null,insertTags:function(to,tags,special,preserve,wraperclass){void 0===wraperclass&&(wraperclass="tag");var cls="."+wraperclass,old={};void 0===preserve&&($("span"+cls+":not(:has(a:first-child[class]))",to).remove(),$("span"+cls,to).each(function(){old[$(this).find("a:first-child").text()]=$(this).detach()})),$.each(tags,function(i){if("object"==typeof old[tags[i]])return void($("span"+cls+" a:first-child[class]",to).length?$("span"+cls+":has(a:first-child[class]):last",to).after(old[tags[i]]):$(to).prepend(old[tags[i]]));var clas="";void 0!==special&&void 0!==special[tags[i]]&&(clas='class="'+special[tags[i]]+'"'),$("label",to).before('<span class="'+wraperclass+'"><a '+clas+">"+tags[i]+'</a><a class="cls">x</a></span>')})},bindTagsActions:function(root,tip,oninsert,onremove){$(root+" input").bind("focus click",function(){$(this).css({filter:"alpha(opacity=100)",opacity:"1"}),setTimeout('ticket.showMatchingTags("'+root+' ul","'+this.value+'",'+tip+")",100)}).blur(function(){0==this.value.length&&$(this).css({filter:"alpha(opacity=80)",opacity:"0.8"})}),$(root).undelegate("input","keydown").delegate("input","keydown",function(event){if(13==event.keyCode)return event.preventDefault(),!1}).undelegate("input","keyup").delegate("input","keyup",function(e){if(ticket.showMatchingTags(root+" ul",this.value,tip),0!=this.value.length){if(13==e.which){e.preventDefault();var tag=$.trim(this.value).replace(/[#$%^&*(){}~`\[\]:;"'?|+\/><,]/g,"");if(0==tag.length)return;if($(root+" span a:first-child").filter(function(){return this.innerHTML==tag}).length>0)return;tag=$("<i/>").text(tag).html(),ticket.insertTags(root,[tag],[],!0),"function"==typeof oninsert&&oninsert(tag),this.value="",ticket.showMatchingTags(root+" label ul","",tip)}return!1}}),$(root+" ul").undelegate("li","click").delegate("li","click",function(){var ev=jQuery.Event("keyup");ev.which=13,$(root+" input").val(this.innerHTML).trigger(ev)}),$(root).undelegate("span a:last-child","click").delegate("span a:last-child","click",function(){if($(this).prev("a").hasClass("shared")&&!confirm(lang.unshare_confirm))return!1;$(this).parent().remove(),"function"==typeof onremove&&onremove($(this).siblings().text())}),$(document).undelegate(root,"click").delegate(root,"click",function(e){$(e.target).is(root)&&$("label input",this).focus()})},alignColumns:function(){var sub=$(".view2048").length;$(".tviews:not(.view2048)").filter(function(){return!$(this).attr("width")}).each(function(no){var that=$(this),index=that.index()+1,elems=that.parents("table").eq(0).find("td:nth-child("+index+"), th:nth-child("+index+")"),width=0;elems.each(function(){var self=$(this),tag=self.children(".inlineTags"),lwidth=0;tag.length?lwidth=self.children().width():(lwidth=self.wrapInner("<span></span>").children().width(),self.children().children().unwrap()),lwidth>width&&(width=lwidth)}),(sub||no)&&that.width(width+10)})},autopoll:!0,ticketpoll:!1,ticketpollinterwal:uiSettings.TicketPollInterval?1e3*uiSettings.TicketPollInterval:15e3,poolSince:Math.floor((Date.now?Date.now():(new Date).getTime())/1e3),initPoll:function(){clearTimeout(ticket.ticketpoll),ticket.ticketpoll=setTimeout(function(){ticket.poll(ticket.autopoll)},ticket.ticketpollinterwal)},poll:function(){if($("#ticketsubmitter").prop("disabled"))return!1;if($("a.selected","#content_tb").attr("rel")){var dept_id=$(".selected",".leftNav").parent("div").length?$("div:has(.selected)",".leftNav").attr("id"):$(".selected",".leftNav").attr("id");if(!dept_id)return autopoll=!0,!1;$.post($("#currentlist").attr("href"),{id:$("#ticket_number").val(),make:"poll",page:parseInt($(".pagination span.current","#testform").eq(0).html())-1,body:$("#replyarea").val(),list:$("a.selected","#content_tb").length?$("a.selected","#content_tb").attr("rel"):"all",dept:dept_id.match(/\d*$/),assigned:$("#dept_my").hasClass("selected")?1:$("a.selected","#content_tb").parent("#listdept_my,#dept_my").length?1:0,since:ticket.poolSince,ticket_id:$("#ticket_id").val(),save_draft:$("input[name=save_draft]").val()}).done(function(data){if("object"!=typeof data){var checks=$("#updater input:checked"),htm=parse_response(data);return $("#updater").html($(htm).find("input[type=checkbox]").filter(function(){return!!checks.filter("input[value="+$(this).val()+"]").length}).prop("checked",!0).each(checkEl).end().end()),ticket.initPoll(),!1}if(data.draftsave&&$("#draftinfo .draftdate").html(lang.draftsavedat+" "+data.draftsave),$("#alreadyreply").empty(),data.adminreply){for(var now=$.now()/1e3,disable_replyarea=!1,i=0,l=data.adminreply.length;i<l;i++){var drafthtml='<div class="alert alert-info" style="padding: 8px; margin-bottom: 8px;">',draft=data.adminreply[i],stored=lang.startedreplyat;draft.stored<=now&&(stored=lang.storedreplyat,drafthtml='<div class="alert alert-default" style="padding: 8px; margin-bottom: 8px; background-color: #eee;"> ');$("input[name=lock]").val();drafthtml+='<p class="adminr_'+draft.replier_id+'" style="float: left; margin-top: 3px;"><strong>'+draft.name+"</strong> "+stored+" "+draft.date+'</p><p style="float: right; margin-top: 0;"><a href="#previewDraft" class="btn btn-sm btn-primary" data-draft="'+draft.id+'" data-draft-by="'+draft.name+'">'+lang.preview+"</a>",data.admin_acl.removeTicketReplyLock&&8&draft.flags&&data.lock_ticket_reply&&(drafthtml+='\n<button type="button" class="btn btn-sm btn-primary remove-lock" data-id="'+draft.id+'">'+lang.removelock+"</button>"),data.admin_acl.replyToTicketsWithReplyLock&&8&draft.flags&&data.lock_ticket_reply&&!$("#replyarea").val()?drafthtml+='\n<button type="button" class="btn btn-sm btn-primary without-removing" data-id="'+draft.id+'">'+lang.withoutremoving+"</button>":drafthtml+='<input type="hidden" name="lock" value="'+draft.md5+'">',drafthtml+='</p><div style="clear: both;"></div>',$("#alreadyreply").append(drafthtml+"</div>"),8&draft.flags&&data.lock_ticket_reply&&!$("#replyarea").val()&&(disable_replyarea=!0)}$("#replyarea").prop("disabled",disable_replyarea)}else $("#replyarea").prop("disabled",!1);data.newreply&&$("#justadded").ShowNicely(),data.tags&&ticket.updateTags(data.tags),ticket.initPoll()}).fail(function(){ticket.initPoll()}),ticket.poolSince=Math.floor((Date.now?Date.now():(new Date).getTime())/1e3)}else ticket.initPoll()},updateTags:function(tags){var box=$("#tagsBox");if(box.html(""),void 0==tags||tags.length<1)return void box.parents(".tagNav").hide();for(var i=0;i<tags.length;i++){var display="";tags[i].visible||(display="display:none;"),box.append('<span class="tag'+tags[i].group+'" style="'+display+"background-color:"+tags[i].color+";opacity:"+tags[i].usage+"; filter: alpha(opacity = "+100*tags[i].usage+');">'+tags[i].tag+"</span> ")}box.parents(".tagNav").show(),box.trigger("tag.update",[tags])},savedraft:function(){return ajax_update("?cmd=tickets",{make:"savedraft",action:"menubutton",id:$("#ticket_number").val(),body:$("#replyarea").val()},"#draftinfo .draftdate"),$("#draftinfo .draftdate").show(),!1},removedraft:function(){return ajax_update("?cmd=tickets",{make:"removedraft",action:"menubutton",id:$("#ticket_id").val()}),$("#draftinfo .draftdate").html("").hide(),$("#draftinfo .controls").hide(),$("#replyarea").val(""),!1},loadReply:function(id){$.post("?cmd=tickets",{make:"loadreply",action:"menubutton",id:id},function(data){data.reply&&($("#previewinfo .left").html(data.reply),$("#previewinfo").show())})},renderBilling:function(data){$("#ticketbils > .panel-body").html(parse_response(data)),$("select.chosenedge","#ticketbils").chosenedge({width:"100%"}),$(".inp-controls a").on("click",function(){var self=$(this),inp=self.parent().prev(),time=inp.timepicker("getTime"),mod=self.is(".plus")?30:-30;return time=new Date(time.getTime()+6e4*mod),inp.timepicker("setTime",time),!1})},getBilling:function(){$.get("?cmd=tickettimetracking&action=ticket&init=1&id="+$("#ticket_id").val(),ticket.renderBilling)},addBilling:function(){var data=$("input, select, textarea","#ticketbils").serializeObject();data.add=!0,$.post("?cmd=tickettimetracking&action=ticket&id="+$("#ticket_id").val(),data,ticket.renderBilling)},delBilling:function(id){$.post("?cmd=tickettimetracking&action=ticket&id="+$("#ticket_id").val(),{delete:id},ticket.renderBilling)},editBilling:function(self,id){var tr=$(self).closest("tr").first();tr.addLoader(),$.post("?cmd=tickettimetracking&action=ticket&id="+$("#ticket_id").val(),{edit_bill:id},function(data){tr.html(data),$(".timepicker").timepicker({timeFormat:"H:i",showDuration:!0}),$(".haspicker").datePicker(),$(".inp-controls a").on("click",function(){var self=$(this),inp=self.parent().prev(),time=inp.timepicker("getTime"),mod=self.is(".plus")?30:-30;return time=new Date(time.getTime()+6e4*mod),inp.timepicker("setTime",time),!1})})},saveBilling:function(id){var data=$("input, select, textarea","#ticketbilsedit").serializeObject();data.edit=!0,$.post("?cmd=tickettimetracking&action=ticket&id="+$("#ticket_id").val(),data,ticket.renderBilling)},startBilling:function(type,service){$.post("?cmd=tickettimetracking&action=ticket&id="+$("#ticket_id").val(),{start:!0,type:type,service:service},ticket.renderBilling)},renderTimers:function(data){$("#ticketTimersBox > .panel-body").html(parse_response(data)),$("select.chosenedge","#ticketTimersBox").chosenedge({width:"100%"}),$(".inp-controls a").on("click",function(){var self=$(this),inp=self.parent().prev(),time=inp.timepicker("getTime"),mod=self.is(".plus")?30:-30;return time=new Date(time.getTime()+6e4*mod),inp.timepicker("setTime",time),!1})},getTimers:function(){return ajax_update("?cmd=tickettimers&action=ticket&id="+$("#ticket_id").val(),{},"#ticketTimersBox > .panel-body",!0),!1},getInvoices:function(){return ajax_update("?cmd=tickets&action=ticketinvoices&id="+$("#ticket_id").val(),{},"#ticketInvoicesBox > .panel-body",!0),!1},getQueuedInvoiceItems:function(){return ajax_update("?cmd=tickets&action=queuedinvoiceitems&id="+$("#ticket_id").val(),{},"#QueuedInvoiceItemsBox > .panel-body",!0),!1},deleteQueuedInvoiceItem:function(id){return ajax_update("?cmd=tickets&action=queuedinvoiceitems&make=delete&id="+$("#ticket_id").val()+"&item_id="+id,{},"#QueuedInvoiceItemsBox > .panel-body",!0),!1},addQueuedInvoiceItem:function(form){return $("#queueItemNewModal").modal("hide"),ajax_update("?cmd=tickets&action=queuedinvoiceitems&make=add&id="+$("#ticket_id").val(),$(form).serialize(),"#QueuedInvoiceItemsBox > .panel-body",!0),ticket.getInvoices(),!1},loadWidet:function(url){return ajax_update(url,{ticket_number:$("#ticket_number").val()},"#ticketwidget",!0),!1}};