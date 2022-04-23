import 'shiny';
import 'jquery';
import Shepherd from 'shepherd.js';
import 'shepherd.js/dist/css/shepherd.css';
import './custom.css';

let tour = [];
let tourEvents = ["complete", "cancel", "start", "hide", "show", "active", "inactive"];
let stepEvents = ["before-show", "show", "before-hide", "hide", "complete", "cancel", "destroy"];

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

  // Add step counter
  // https://github.com/shipshapecode/shepherd/issues/1269#issuecomment-742129621
  if (opts.globals.progress == true) {
    opts.globals.defaultStepOptions.when =  {
      show() {
        const currentStep = Shepherd.activeTour?.getCurrentStep()
        if (!currentStep)
          return
        const currentStepElement = currentStep.getElement()
        if (!currentStepElement)
          return
        const header = currentStepElement.querySelector('.shepherd-header')
        if (!header)
          return
        const progress = document.createElement('span')
        progress.innerText = `${tour[opts.id].steps.indexOf(currentStep) + 1}/${tour[opts.id].steps.length}`
        header.insertBefore(progress, currentStepElement.querySelector('.shepherd-cancel-icon'))
      }
    }
  }

  // Default popperOptions
  opts.globals.defaultStepOptions.popperOptions = {
    modifiers: [{ name: 'offset', options: { offset: [0, 12] } }]
  }

  // Create empty tour
  tour[opts.id] = new Shepherd.Tour(opts.globals);

  // Run code when tour is complete, cancelled, etc.
  tourEvents.forEach(event => tour[opts.id].on(event, () => {
    if (opts.globals["on" + toTitleCase(event)]) {
      new Function("return " + opts.globals["on" + toTitleCase(event)])()
    }
  }))

  // Check at each step
  opts.steps.forEach((step, index) => {

    // Mathjax rendering
    if (opts.mathjax) {
      opts.steps[index].when = {
        show: function(element){setTimeout(function(){
            MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
          }, 100);
        }
      }
    }

    // Switch tab
    if (typeof opts.steps[index].tabId !== "undefined") {
      opts.steps[index].when = {
        show: function(element){
          var tabs = $('#' + opts.steps[index].tabId);
          console.log(tabs);
          Shiny.inputBindings.bindingNames['shiny.bootstrapTabInput'].binding.setValue(tabs, opts.steps[index].tab);
        }
      }
    }

    // Evaluate showOn to know whether the step should be shown
    if (typeof opts.steps[index].showOn != undefined) {
      if (typeof opts.steps[index].showOn == "boolean") {
        opts.steps[index].showOn = "() => {return " + opts.steps[index].showOn.toString() + "}"
      }
      opts.steps[index].showOn = new Function("return " + opts.steps[index].showOn)()
    }
  });

  tour[opts.id].addSteps(opts.steps)

})

Shiny.addCustomMessageHandler('conductor-start', (opts) => {
  tour[opts.id].start();
  Shiny.setInputValue(
    opts.id + '_is_active', true
  );
})

Shiny.addCustomMessageHandler('conductor-showStep', (opts) => {
  tour[opts.id].show(opts.step);
})

Shiny.addCustomMessageHandler('conductor-removeStep', (opts) => {
  opts.step.forEach(name => {
    tour[opts.id].removeStep(name);
  })
})

Shiny.addCustomMessageHandler('conductor-next', (opts) => {
  tour[opts.id].next();
})

Shiny.addCustomMessageHandler('conductor-back', (opts) => {
  tour[opts.id].back();
})

Shiny.addCustomMessageHandler('conductor-cancel', (opts) => {
  tour[opts.id].cancel();
})

Shiny.addCustomMessageHandler('conductor-hide', (opts) => {
  tour[opts.id].hide();
})

Shiny.addCustomMessageHandler('conductor-getCurrentStep', (opts) => {
  var currentStep = tour[opts.id].getCurrentStep()
  Shiny.setInputValue(
    opts.id + '_current_step', currentStep.id, {priority: 'event'}
  );
})


let stepUsed;
let targetId;
let targetClass;

// Doesn't work when step specified
// Wait for https://github.com/shipshapecode/shepherd/issues/1891
Shiny.addCustomMessageHandler('conductor-getHighlightedElement', (opts) => {
  if (opts.step != null) {
    stepUsed = tour[opts.id].getById(opts.step)
  } else {
    stepUsed = tour[opts.id].getCurrentStep()
  }

  try {
    targetId = stepUsed.getTarget().id
    targetClass = stepUsed.getTarget().className
  }
  catch(err) {
    targetId = null
    targetClass = null
  }

  Shiny.setInputValue(
    opts.id + '_target_id', targetId, {priority: 'event'}
  );
  Shiny.setInputValue(
    opts.id + '_target_class', targetClass, {priority: 'event'}
  );
})

Shiny.addCustomMessageHandler('conductor-isCentered', (opts) => {
  if (opts.step != null) {
    stepUsed = tour[opts.id].getById(opts.step)
  } else {
    stepUsed = tour[opts.id].getCurrentStep()
  }
  console.log(stepUsed.isCentered())
  Shiny.setInputValue(
    opts.id + '_step_is_centered', stepUsed.isCentered(), {priority: 'event'}
  );
})

Shiny.addCustomMessageHandler('conductor-isOpen', (opts) => {
  if (opts.step != null) {
    stepUsed = tour[opts.id].getById(opts.step)
  } else {
    stepUsed = tour[opts.id].getCurrentStep()
  }
  Shiny.setInputValue(
    opts.id + '_step_is_open', stepUsed.isOpen(), {priority: 'event'}
  );
})

Shiny.addCustomMessageHandler('conductor-isActive', (opts) => {
  Shiny.setInputValue(
    opts.id + '_is_active', tour[opts.id].isActive(), {priority: 'event'}
  );
})

// Doesn't work when step specified
// Wait for https://github.com/shipshapecode/shepherd/issues/1891
Shiny.addCustomMessageHandler('conductor-updateStepOptions', (opts) => {
  if (opts.step != null) {
    stepUsed = tour[opts.id].getById(opts.step)
  } else {
    stepUsed = tour[opts.id].getCurrentStep()
  }
  tour[opts.id].stepUsed.updateStepOptions(opts.new);
})
