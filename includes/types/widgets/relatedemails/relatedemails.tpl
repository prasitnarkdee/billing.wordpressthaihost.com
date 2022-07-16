<div class="wbox">
    <div class="wbox_header">
        {$lang.emails}
    </div>
    <div class="wbox_content">
        {if $emails}
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>{$lang.subject}</th>
                        <th>{$lang.date_sent}</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach from=$emails item=email}
                        <tr>
                            <td>
                                <a href="{$ca_url}clientarea/emails/{$email.id}/" class="roll-link">
                                    <span data-title="{$email.subject}">{$email.subject}</span>
                                </a>
                            </td>
                            <td>{$email.date|dateformat:$date_format}</td>
                            <td>
                                <a href="{$ca_url}clientarea/emails/{$email.id}/" href="">{$lang.show}</a>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        {else}
            <section class="py-4 text-center text-muted m-10">
                {$lang.nothing}
            </section>
        {/if}
    </div>
</div>