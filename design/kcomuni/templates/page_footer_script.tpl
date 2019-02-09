{* Override this template and place javascript based statestics here (like Google Analytics) *}

<!--[if lt IE 9]>
   <script src={"assets/plugins/respond.min.js"|ezdesign}></script>
   <script src={"assets/plugins/excanvas.min.js"|ezdesign}></script> 
   <![endif]-->
   {if $module_result.uri|ne('/pratiche/content/browse')}
<script src={"assets/plugins/jquery-1.10.2.min.js"|ezdesign} type="text/javascript"></script>

{/if}
<script src={"assets/plugins/jquery-migrate-1.2.1.min.js"|ezdesign} type="text/javascript"></script>

<script src={"assets/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/plugins/bootstrap/js/bootstrap.min.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/plugins/bootstrap-hover-dropdown/twitter-bootstrap-hover-dropdown.min.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/plugins/jquery-slimscroll/jquery.slimscroll.min.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/plugins/jquery.blockui.min.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/plugins/jquery.cokie.min.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/plugins/uniform/jquery.uniform.min.js"|ezdesign} type="text/javascript"></script>
<script type="text/javascript" src={"assets/plugins/jquery-mixitup/jquery.mixitup.min.js"|ezdesign}></script>
<script type="text/javascript" src={"assets/plugins/fancybox/source/jquery.fancybox.pack.js"|ezdesign}></script>


<script src={"assets/scripts/app.js"|ezdesign} type="text/javascript"></script>
<script src={"assets/scripts/portfolio.js"|ezdesign} type="text/javascript"></script>





{literal}
	<script>
jQuery(document).ready(function() {    
   App.init();
   Portfolio.init();
   
});
</script>
{/literal}
<script src={"assets/scripts/kcomuni.js"|ezdesign} type="text/javascript"></script>

{if $current_node.class_identifier|eq('comune')}
{literal}
<script>
jQuery(document).ready(function() {
jQuery('#coll-but').click();
});
</script>
{/literal}
{/if}
