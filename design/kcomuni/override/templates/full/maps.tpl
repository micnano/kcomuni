{ezscript_require( array( 'shp.min.js') )}
<div class="row">

    { renderizza la mappa }
    <div id="map-{$node.node_id}" style="height: 500px;"></div>

    <script>
		var areas='';
        var map = L.map('map-{$node.node_id}');

     
        map.fitBounds({$arrayForFitBounds});

        { carico il layer di openstreetmap }
        {literal}

        L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18
        }).addTo(map);

       
        {/literal}
        
        {scorro l'array dei dati catastali, aggiungo gli shapefile ed evidenzio le particelle con concessione}
        {foreach $ccarray as $comune => $datacomune}
        
        var geo-{$comune} = {literal}L.geoJson({features:[]},{style: style}).addTo(map);{/literal}
        
        var base-{$comune} ='{$datacomune['shape_file']}';
        
        shp(base-{$comune}).then(function(data){ldelim}
		geo-{$comune}.addData(data);
		{/rdelim});
		
		{foreach $datacomune['pf'] as $pf}
			areas = areas+{$pf}+";";
		
		{/foreach}
        
        
        {/foreach}
        
        
        
        {literal}
 	
 		
 		
 		function style(feature) {
 		if (areas.indexOf(feature.properties.NUM) > -1 ) {
 			return {
				fillColor: '#FF0000',
				weight: 2,
				opacity: 1,
				color: 'white',
				dashArray: '3',
				fillOpacity: 0.4
		    };
		 } else {
			 	return {
				fillColor: '#CCCCCC',
				weight: 2,
				opacity: 1,
				color: 'white',
				dashArray: '3',
				fillOpacity: 0.4
			    };
		 
		 }
 
    
		}
 		
 		
 		
		{/literal}
        
        
        
        
        

    </script>

</div>