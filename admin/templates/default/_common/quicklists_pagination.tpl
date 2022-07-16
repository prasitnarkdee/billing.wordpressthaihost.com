<div class="client-pagination-form form-inline text-right">
    <div class="form-group-sm form-group">
        <strong>{$lang.records_per_page}</strong>
        <select id="client-{$name}-perpage">
            <option value="10" {if $perpage == 10}selected{/if}>10</option>
            <option value="20" {if $perpage == 20}selected{/if}>20</option>
            <option value="50" {if $perpage == 50}selected{/if}>50</option>
            <option value="100" {if $perpage == 100}selected{/if}>100</option>
            <option value="100000" {if $perpage == 100000}selected{/if}>All</option>
        </select>
    </div>
    <div class="form-group">
        <div class="pagination pull-right" data-profile="clientlist"
             data-total-pages="{$totalpages}"
             data-name="client-{$name}"
             data-updater="#client-{$name}-updater"
             data-sorter-link="#client-{$name}-sorter"
             data-per-page-elm="#client-{$name}-perpage"></div>
    </div>
</div>
<a id="client-{$name}-sorter" href="{$url}"></a>