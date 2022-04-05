import 'shiny';
import 'jquery';
import Shepherd from 'shepherd.js';
import 'shepherd.js/dist/css/shepherd.css';

let tour = [];


Shiny.addCustomMessageHandler('docent-init', (opts) => {

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

  if(opts.steps) {
    opts.steps.forEach((step) => {
      tour[opts.id].addStep(step)
    });
  }

})

Shiny.addCustomMessageHandler('docent-start', (opts) => {
  tour[opts.id].start();
})

Shiny.addCustomMessageHandler('docent-isActive', (opts) => {
  Shiny.setInputValue(
    'docent_is_active', tour[opts.id].isActive(), {priority: "event"}
  );
})
