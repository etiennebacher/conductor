import 'shiny';
import 'jquery';
import Shepherd from 'shepherd.js';
import 'shepherd.js/dist/css/shepherd.css';

let tour = [];


Shiny.addCustomMessageHandler('docent-init', (opts) => {
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
