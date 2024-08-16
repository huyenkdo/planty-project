import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import rangePlugin from "flatpickrRangePlugin";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput' ]

  connect() {
    
    flatpickr(this.startDateInputTarget, {
    "plugins": [new rangePlugin({ input: this.endDateInputTarget})]
    })
  }
}
