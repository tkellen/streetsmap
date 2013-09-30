module.exports = {
  title: 'St. Cloud Metro Bus Route Map',
  description: 'View all bus routes and schedules for St. Cloud Metro Bus with a mobile-friendly interactive google map!',
  apikey: 'AIzaSyCuIy2sg0FV6hWvjXor7TEY1B0iJFqmKPc',
  menuWidth: 300,
  map: {
    zoom: 12,
    center: {
      lat: 45.5600,
      lng: -94.1576
    },
    keyboardShortcuts: false,
    scaleControl: true,
    polyline: {
      strokeColor: '#ff0000',
      opacity: 0.6,
      weight: 6
    },
    icon: {
      timePoint: {
        url: 'assets/img/timepoint.png',
        size: [16,16],
        origin: [0,0],
        anchor: [8,8]
      },
      busStop: {
        url: 'assets/img/busstop.png',
        size: [12,12],
        origin: [0,0],
        anchor: [6,6]
      }
    }
  },
  scheduleLink: function(route) {
    var link;
    var input = route.abbr.toLowerCase();
    switch (input) {
      case '31':
      case '32':
        link = '/31_32_sartell.php';
        break;
      case 'nsl':
        link = 'http://catchthelink.com/schedule-fares/';
        break;
      case 'scw':
        link = '/stearns_county_west.php';
        break;
      case 'lne':
      case 'lns':
        link = '/ln.php';
        break;
      default:
        link = '/'+input+'.php';
        break;
    }

    return link;
  }
};
