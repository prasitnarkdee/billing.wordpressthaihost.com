<a class="btn {if $currentfilter}btn-danger{else}btn-default{/if} btn-xs btn-is-filter"
   style="margin-right: 10px" data-filter-modal="#{$loadid}">
    <i class="fa fa-search-plus"></i> Filter Data
</a>

<!-- Modal -->
<div class="modal fade" id="{$loadid}" tabindex="-1" role="dialog"  aria-hidden="true"
     data-filters-url="{$href}" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Search / Filter</h4>

            </div>
            <div class="modal-body" ></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" data-role="apply">Apply filter</button>
                <button type="button" class="btn btn-danger" data-role="reset"
                        {if !$currentfilter}style="display: none"{/if}>Reset filter</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->