module.exports = {
  title: 'Testing & stuff',
  description: '123',
  apikey: 'AIzaSyCuIy2sg0FV6hWvjXor7TEY1B0iJFqmKPc',
  map: {
    zoom: 12,
    center: {
      lat: 45.5600,
      lng: -94.1576
    },
    keyboardShortcuts: false,
    scaleControl: true,
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