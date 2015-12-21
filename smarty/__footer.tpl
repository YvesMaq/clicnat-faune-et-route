<footer class="row">
	<div class="col-lg-12" style="text-align:center;">
			{include file=pied.tpl}
		</div>
	</footer>
</div>
{literal}
<script>$(document).ready(function () { page_accueil_init();});</script>
<!-- Piwik -->
<script type="text/javascript">
var pkBaseURL = (("https:" == document.location.protocol) ? "https://stats.picardie-nature.org/" : "http://stats.picardie-nature.org/");
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
</script><script type="text/javascript">
try {
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 7);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</script><noscript><p><img src="http://stats.picardie-nature.org/piwik.php?idsite=7" style="border:0" alt="" /></p></noscript>
<!-- End Piwik Tracking Code -->
{/literal}
