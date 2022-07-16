"use strict";var HBFiles=function(){var parseThumbnailElements=function(el){var hbfileElements=$(el).find(".hbfile"),items=[];return $(hbfileElements).each(function(){var self=$(this);isImage(self)&&items.push({dsrc:self.attr("data-download-url"),src:self.attr("data-preview-url"),w:0,h:0,title:self.attr("data-title"),el:this})}),items},isImage=function(el){var type=$(el).attr("data-type");return!!type&&["png","jpg","jpeg","gif"].includes(type)},onThumbnailsClick=function(e){e=e||window.event;var eTarget=e.target||e.srcElement,hbfile=$(eTarget).closest(".hbfile");if(!isImage(hbfile))return hbfile.attr("data-download-url")&&window.open(hbfile.attr("data-download-url")),!1;e.preventDefault?e.preventDefault():e.returnValue=!1;var index,clickedGallery=$(hbfile).closest(".hbfiles");return index=clickedGallery.find(".hbfile.hbfile-image").index(hbfile),index>=0&&openPhotoSwipe(index,clickedGallery),!1},openPhotoSwipe=function(index,galleryElement){var gallery,options,items;document.querySelectorAll(".pswp")[0];if(items=parseThumbnailElements(galleryElement),options={galleryUID:$(galleryElement).attr("data-pswp-uid"),showAnimationDuration:0,hideAnimationDuration:0,bgOpacity:.8,history:!1,index:index,shareButtons:[{id:"download",label:"Download image",url:"{{raw_image_url}}",download:!0}],getImageURLForShare:function(shareButtonData){return gallery.currItem.dsrc||""},getThumbBoundsFn:function(index){var hbfile=(items[index].el.getElementsByTagName("img"),items[index].el.getElementsByTagName("img")[0]),pageYScroll=window.pageYOffset||document.documentElement.scrollTop;if(!hbfile)return!1;var rect=hbfile.getBoundingClientRect();return{x:rect.left,y:rect.top+pageYScroll,w:rect.width}}},options.index=parseInt(index,10),!isNaN(options.index)){$("body").append('<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">\n    <div class="pswp__bg"></div>\n    <div class="pswp__scroll-wrap">\n        <div class="pswp__container">\n            <div class="pswp__item"></div>\n            <div class="pswp__item"></div>\n            <div class="pswp__item"></div>\n        </div>\n        <div class="pswp__ui pswp__ui--hidden">\n            <div class="pswp__top-bar">\n                <div class="pswp__counter"></div>\n                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>\n                <button class="pswp__button pswp__button--download" title="Download"></button>\n                <div class="pswp__preloader">\n                    <div class="pswp__preloader__icn">\n                        <div class="pswp__preloader__cut">\n                            <div class="pswp__preloader__donut"></div>\n                        </div>\n                    </div>\n                </div>\n            </div>\n            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">\n                <div class="pswp__share-tooltip"></div>\n            </div>\n            <button class="pswp__button pswp__button--arrow--left" title="Previous"></button>\n            <button class="pswp__button pswp__button--arrow--right" title="Next"></button>\n            <div class="pswp__caption">\n                <div class="pswp__caption__center"></div>\n            </div>\n        </div>\n    </div>\n</div>');var gallery=new PhotoSwipe($(".pswp")[0],PhotoSwipeUI_Default,items,options);gallery.listen("imageLoadComplete",function(index,item){if(item.h<1||item.w<1){var img=new Image;$(img).on("load",function(){item.w=img.width,item.h=img.height,gallery.invalidateCurrItems(),gallery.updateSize(!0)}),img.src=item.src}}),gallery.init()}};return{init:function(gallerySelector){gallerySelector=gallerySelector||".hbfiles",$(gallerySelector).each(function(i){$(this).find(".hbfile").each(function(){var file=$(this),type=file.attr("data-type"),placeholder=file.find("img.hbfile-placeholder");isImage(file)?(file.addClass("hbfile-image"),placeholder.attr("src",file.attr("data-thumbnail-url"))):(placeholder.remove(),file.find(".hbfile-placeholder-box").append('<div class="hbfile-placeholder hbfile-placeholder-empty"><i class="fa fa-paperclip"></i><div>'+(type||"")+"</div></div>"))}),$(this).attr("data-pswp-uid",i+1).on("click",".hbfile-placeholder-box",onThumbnailsClick)})}}}();jQuery(document).ready(function(){HBFiles.init()});