{if $rss}
{foreach from=$rss item=feed}
<a href="{$feed.link}" title="{$feed.title}" target="_blank">{$feed.title}</a><br/>
<span style="color:#B0B0B0;font-size:11px;">{$feed.pubDate}</span><br/>
{$feed.description}<br/>
{/foreach}
{/if}