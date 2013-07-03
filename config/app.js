module.exports = {
  title: 'Route Map',
  description: '123',
  apikey: 'AIzaSyCuIy2sg0FV6hWvjXor7TEY1B0iJFqmKPc',
  map: {
    zoom: 13,
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
        url: '/assets/img/timepoint.png',
        size: [16,16],
        origin: [0,0],
        anchor: [8,8]
      },
      busStop: {
        url: '/assets/img/busstop.png',
        size: [10,10],
        origin: [0,0],
        anchor: [5,5]
      }
    }
  },
  scheduleLink: function(input) {
    return '/'+input.abbr.toLowerCase()+'.php';
  }
};