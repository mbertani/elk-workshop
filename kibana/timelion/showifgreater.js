var reduce = require('../lib/reduce.js');

var Chainable = require('../lib/classes/chainable');
module.exports = new Chainable('showIfGreater', {
  args: [
    {
      name: 'inputSeries',
      types: ['seriesList']
    },
    {
      name: 'compare',
      types: ['seriesList', 'number']
    } 
  ],
  help: 'Shows each point in inputSeries if it is larger than the equivalent point in the compared series',
  fn: function divideFn(args) {
    return reduce(args, function (a, b) {
      return a > b ? a : null;
    });
  }
});   