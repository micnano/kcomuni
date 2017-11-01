<h3 class="page-title"><i class="fa fa-home fa-1x"></i> {$node.name}</h3>



{if $node.data_map.address.has_content}

  <div class="portlet box blue">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-reorder"></i>Mappa
							</div>
							<div class="tools">
								<a href="javascript:;" class="collapse"></a>
							</div>
						</div>
						<div class="portlet-body">

 <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.5/leaflet.css" />


<div id="map" style="width: 100%; height: 800px"></div>

<script src="http://cdn.leafletjs.com/leaflet-0.7.5/leaflet.js"></script>
<script src={"javascript/shp.min.js"|ezdesign}> </script>

<script>
var m = L.map('map').setView([{$node.data_map.address.content.latitude|explode(',')|implode('.')}, {$node.data_map.address.content.longitude|explode(',')|implode('.')}], 14);
{literal}
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors', maxZoom: 20
		}).addTo(m);
{/literal}

{if $node.data_map.shape.has_content}
{def $attributef = $node.data_map.shape
		$link=concat( 'content/download/', $attributef.contentobject_id, '/', $attributef.id,'/version/', $attributef.version , '/file/', $attributef.content.original_filename|urlencode )}

{literal}
 var geo = L.geoJson({features:[]},{style: style,onEachFeature:onEachFeature}).addTo(m);
{/literal}
      var base = '{$link}';
	
{literal}
	shp(base).then(function(data){
		geo.addData(data);
		});



function style(feature) {
    return {
        fillColor: '#CCCCCC',
        weight: 2,
        opacity: 1,
        color: 'white',
        dashArray: '3',
        fillOpacity: 0.4
    };
}

function highlightFeature(e) {
    var layer = e.target;

    layer.setStyle({
        weight: 5,
        color: '#666',
        dashArray: '',
        fillOpacity: 0.7
    });

    if (!L.Browser.ie && !L.Browser.opera) {
        layer.bringToFront();
    }
info.update(layer.feature.properties);
}

function resetHighlight(e) {
    geo.resetStyle(e.target);
info.update();
}

function zoomToFeature(e) {
    m.fitBounds(e.target.getBounds());
}

function onEachFeature(f, l) {
    l.on({
        mouseover: highlightFeature,
        mouseout: resetHighlight,
        click: zoomToFeature
    });

var out = [];
    		if (f.properties){
        		for(var key in f.properties){
            	out.push(key+": "+f.properties[key]);
        }

	

        l.bindPopup(out.join("<br />"));

    }
}

var info = L.control();

info.onAdd = function (map) {
    this._div = L.DomUtil.create('div', 'info'); // create a div with a class "info"
    this.update();
    return this._div;
};

// method that we will use to update the control based on feature properties passed
info.update = function (props) {
    this._div.innerHTML = '<h4>Informazioni particella</h4>' +  (props ?
        '<b>' + props.NUM + '</b><br />' + props.AREA + '  m<sup>2</sup>'
        : 'Passa con il mouse su una particella');
};

info.addTo(m);




		
{/literal}
{/if}



</script>	
<style>

.info {
    padding: 6px 8px;
    font: 14px/16px Arial, Helvetica, sans-serif;
    background: white;
    background: rgba(255,255,255,0.8);
    box-shadow: 0 0 15px rgba(0,0,0,0.2);
    border-radius: 5px;
}
.info h4 {
    margin: 0 0 5px;
    color: #777;
}

</style>







					</div>
	</div>

{/if}








