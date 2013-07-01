

var currentwindow, height, width, phash, thash, map;

var tp = new google.maps.MarkerImage(
  'img/dot.png',
  new google.maps.Size(16,16),
  new google.maps.Point(0,0),
  new google.maps.Point(8,8)
);

var bs = new google.maps.MarkerImage(
  'img/busdot.png',
  new google.maps.Size(10,10),
  new google.maps.Point(0,0),
  new google.maps.Point(5,5)
);

function max (array) {
  return Math.max.apply(Math,array);
}

function min (array) {
  return Math.min.apply(Math,array);
}

function lum (hex) {
  var rgb = [];
  rgb.push(parseInt(hex.substring(1,3),16));
  rgb.push(parseInt(hex.substring(3,5),16));
  rgb.push(parseInt(hex.substring(5,7),16));

  var result = (max(rgb)+min(rgb))/510.0;
  if(result < 0.45) return 'white';
  else
  return 'black';
}

function coord (lat, lng) {
  return new google.maps.LatLng(lat,lng);
}



function attach_infobox (marker, data) {
  var infowindow = new google.maps.InfoWindow({content:data});
  google.maps.event.addListener(marker,'click',function () {
    if(currentwindow) currentwindow.close();
    infowindow.open(map,marker);
    currentwindow = infowindow;
  });
}

function add_marker (lat, lng, title, icon) {
  var marker = new google.maps.Marker({
     position: coord(lat,lng),
     map: map,
     title: title,
     icon: icon
  });
  return marker;
}


function load_points (points, icon, route) {
  for (var point in points) {
    var p = thash[points[point]];
    if(!p) {
      alert('failed to locate point');
      continue;
    }
    var name = p.name;
    var lat = parseFloat(p.lat).toFixed(5);
    var lng = parseFloat(p.lng).toFixed(5);
    if(!p.status) {
      var marker = add_marker(lat,lng,name,icon);
      attach_infobox(marker,build_info(p,points[point],name,lat,lng));
      p.status = {'marker':marker,'active':[]};
    }
    p.status.active.push(route);
  }
  sizemap();
}

function toggle_points (onoff, points, route) {
  for(var point in points) {
    var p = thash[points[point]];
    if(p) {
      if(p.status) {
        var i = jQuery.inArray(route,p.status.active);
        switch(onoff) {
          case "on":
            if(i == -1) p.status.active.push(route);
            p.status.marker.setMap(map);
            break;
          case "off":
            if(i != -1) p.status.active.splice(i,1);
            if(p.status.active.length === 0) p.status.marker.setMap(null);
            break;
        }
      }
    }
  }
}

function build_info (p, idx, name, lat, lng) {
  var link, color;
  var html = '';
  html += '<div class="infowindow">';
  html += '<h2>'+name+'</h2><br/>';
  html += '<strong>Stop&nbsp;&nbsp;&nbsp;Route</strong><br/><br/>';
  for(var i in p.usedby) {
    var route = p.usedby[i];
    name = phash[route].name;
    for(i in phash[route].timepoints) {
      var timepoint = phash[route].timepoints[i];
      if(timepoint != idx) {
        continue;
      }
      link = 'http://www.ridemetrobus.com/'+name.toLowerCase()+'.php';
      color = phash[route].color;
      html += '&nbsp;<span class="timepoint" style="color:'+lum(color)+';background-color:'+color+'">'+(parseInt(i, 10)+1)+'</span>';
      html += '&nbsp;&nbsp;&nbsp;&nbsp;';
      html += route+' ';
      html += '(';
      html += '<a href="'+link+'" title="'+route+' Schedule" onclick="window.open(this.href);return false">schedule</a>';
      html += ')<br/><br/>';
    }

    for(i in phash[route].busstops)
    {
      var buspoint = phash[route].busstops[i];
      if(buspoint != idx) {
        continue;
      }
      link = 'http://www.ridemetrobus.com/'+name.toLowerCase()+'.php';
      color = phash[route].color;
      html += '&nbsp;<span class="buspoint" style="color:'+lum(color)+';background-color:'+color+'"></span>';
      html += '&nbsp;&nbsp;&nbsp;&nbsp;';
      html += route+' ';
      html += '(';
      html += '<a href="'+link+'" title="'+route+' Schedule" onclick="window.open(this.href);return false">schedule</a>';
      html += ')<br/><br/>';
    }
  }
  html += '<center><a href="javascript:;" onclick="map.setCenter(coord('+lat+','+lng+'));map.setZoom(16)\">Zoom In Here</a></center><br/>';
  html += '<center><a href="javascript:;" onclick="map.setCenter(coord('+lat+','+lng+'));map.setZoom(13)\">Zoom Out</a></center>';
  html += '</div>';

  return html;
}

function toggle_route (ob, route, flag) {
  var status = phash[route].status;

  if(currentwindow) {
    currentwindow.close();
  }
  if($(ob).toggleClass('on').hasClass('on')) {
    status.visible = true;
    phash[route].polyline.setMap(map);
    toggle_points('on', phash[route].timepoints, route);
  }
  else {
    status.visible = false;
    phash[route].polyline.setMap(null);
    toggle_points('off', phash[route].timepoints, route);
    if(status.bsvisible) {
      $(ob).prev().trigger('click');
    }
  }
}

function toggle_route_busstops (ob, route, flag) {
  var status = phash[route].status;

  if(currentwindow) {
    currentwindow.close();
  }
  if($(ob).toggleClass('on').hasClass('on')) {
    if(!status.bsloaded) {
      status.bsloaded = true;
      status.bsvisible = true;
      load_points(phash[route].busstops, bs, route);
    } else {
      status.bsvisible = true;
      toggle_points('on', phash[route].busstops, route);
    }
    if(!status.visible) {
      $(ob).next().trigger('click');
    }
  }
  else {
    phash[route].status.bsvisible = false;
    toggle_points('off', phash[route].busstops, route);
  }
}

function setup () {
  map = new google.maps.Map(document.getElementById('googlemap'), {
    zoom: 13,
    scrollwheel: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    navigationControl: true,
    navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
    scaleControl: true,
    center: coord(45.5600,-94.1576)
  });

  for(var route in phash) {
    var id = route.replace(' ','_');
    var line = [];
    var color = phash[route].color;
    for(var point in phash[route].linepoints) {
      var p = phash[route].linepoints[point];
      line.push(coord(p[0], p[1]));
    }
    load_points(phash[route].timepoints, tp, route);

    phash[route].polyline = polyline(line, color, 0.5);
    phash[route].status = {
      bsloaded: false,
      bsvisible: false,
      visible: true
    };

    var html = '';
    html += '<div class="route">';
    html += '  <div class="circle" style="background-color:'+color+';"/>';
    html += route;
    html += ' <span style="font-size:10px">(<a href="http://www.ridemetrobus.com/'+phash[route].name.toLowerCase()+'.php" onclick="window.open(this.href);return false">schedule</a>)</span>';
    html += '  <div class="busstopbox" onclick="toggle_route_busstops(this,\''+route+'\')"/>';
    html += '  <div class="routebox on" onclick="toggle_route(this,\''+route+'\')"/>';
    html += '</div>';
    $('#legend').append(html);
  }

  $('#legend,#legendcontrol').css('-moz-user-select','none')
                             .bind('selectstart',function(){return false;})
                             .bind('mousedown',function(){return false;});
  $(window).resize(sizemap);
}
