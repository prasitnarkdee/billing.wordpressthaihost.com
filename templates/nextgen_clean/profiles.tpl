<div class="row flex-container ">
    <div class="span2  flex-box-1 box-feature-small">
        {include file='clientarea/leftnavigation.tpl'}
    </div>
    <div class="span10  flex-box-1 bordered-section article iep">
        {if $action=='add' || $action=='edit' || $action=='invite' || $action=='access'}
            {include file='contacts/add_edit.tpl'}
        {else}
            {include file='contacts/contacts.tpl'}
        {/if}
    </div>
</div>