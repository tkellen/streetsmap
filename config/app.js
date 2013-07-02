module.exports = {
  title: 'Route Map',
  description: '123',
  apikey: 'AIzaSyCuIy2sg0FV6hWvjXor7TEY1B0iJFqmKPc',
  map: {
    zoom: 11,
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
    icons: {
      timePoint: {
        url: '/assets/img/timepoint.png'
      }
    }
  },
  scheduleLink: function(input) {
    return '/'+input.abbr.toLowerCase()+'.php';
  }
};