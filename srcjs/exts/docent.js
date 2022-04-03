import 'shiny';
import 'jquery';
import Shepherd from 'shepherd.js';
import 'shepherd.js/dist/css/shepherd.css';

let tour = [];


Shiny.addCustomMessageHandler('docent-init', (opts) => {
  console.log("init");
  tour[opts.id] = new Shepherd.Tour({
    useModalOverlay: true,
    defaultStepOptions: {
        popperOptions: {
          modifiers: [{ name: 'offset', options: { offset: [0, 12] } }]
        },
        buttons: [
          {
            action() {
              return this.back();
            },
            classes: 'shepherd-button-secondary',
            text: 'Before'
          },
          {
            action() {
              return this.next();
            },
            text: 'Next'
          }
        ]
      }
  });

  console.log(opts.steps);
  if(opts.steps) {
    opts.steps.forEach((step) => {
      tour[opts.id].addStep(step)
    });
  }

})

Shiny.addCustomMessageHandler('docent-start', (opts) => {
  console.log("start");
  tour[opts.id].start();
})
