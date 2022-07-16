{if $exported}
    <div class="btn-group">
        <button type="button" class="btn btn-sm btn-success">
            Synchronized with TaxJar
        </button>
    </div>
{elseif !$can_export}
    <div class="btn-group">
        <button type="button" class="btn btn-sm btn-warning">
            Unable to sync with TaxJar
        </button>
    </div>
{else}
    <a class="btn btn-sm btn-danger"
       href="?cmd=taxjar&selected={$id}&security_token={$security_token}&redirect={$back|escape:'url'}">
        Sync with TaxJar
    </a>
{/if}