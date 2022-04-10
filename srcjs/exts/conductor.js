import 'shiny';
import 'jquery';
import Shepherd from 'shepherd.js';
import 'shepherd.js/dist/css/shepherd.css';
import './custom.css';

let tour = [];
let events = ["complete", "cancel", "start", "hide", "show", "active", "inactive"];

// https://stackoverflow.com/a/196991/11598948
function toTitleCase(str) {
  return str.replace(
    /\w\S*/g,
    function(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    }
  );
}


Shiny.addCustomMessageHandler('conductor-init', (opts) => {

  // Put default buttons
  if (opts.globals.defaultStepOptions == null) {
    opts.globals.defaultStepOptions = {}
  }

  if (opts.globals.defaultStepOptions.buttons === undefined) {
    opts.globals.defaultStepOptions.buttons =  [
      {
        action: function() {return this.back();},
        secondary: true,
        text: 'Previous'
      },
      {
        action: function() {return this.next();},
        text: 'Next'
      }
    ]
  }

  opts.globals.defaultStepOptions.popperOptions = {
    modifiers: [{ name: 'offset', options: { offset: [0, 12] } }]
  }

  tour[opts.id] = new Shepherd.Tour(opts.globals);

  // Run code when tour is complete, cancelled, etc.
  events.forEach(event => tour[opts.id].on(event, () => {
    if (opts.globals["on" + toTitleCase(event)]) {
      new Function("return " + opts.globals["on" + toTitleCase(event)])()
    }
  }))

  opts.steps.forEach((step, index) => {
    if (opts.mathjax) {
      opts.steps[index].when = {
        show: function(element){setTimeout(function(){
            MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
          }, 100);
        }
      }
    }
    tour[opts.id].addStep(step)
  });


})

Shiny.addCustomMessageHandler('conductor-start', (opts) => {
  tour[opts.id].start();
})

Shiny.addCustomMessageHandler('conductor-isActive', (opts) => {
  Shiny.setInputValue(
    'conductor_is_active', tour[opts.id].isActive(), {priority: "event"}
  );
})
