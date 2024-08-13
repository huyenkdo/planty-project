import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import rangePlugin from "flatpickrRangePlugin";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput' ]

  connect() {
    console.log("coucou")
    flatpickr(this.startDateInputTarget, {
    "plugins": [new rangePlugin({ input: this.endDateInputTarget})]
    })
  }
}
