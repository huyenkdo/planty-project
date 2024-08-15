import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dynamic-booking-price"
export default class extends Controller {
 // Connects to data-controller="dynamic-booking-price"
  // Define targets to retrieve elements from the DOM
  static targets = ['startDateInput', 'endDateInput', 'priceHolder']
  // Define a value to store the price per day
  static values = { price: Number }

  // This function is triggered whenever the date inputs change
  updatePrice() {
    // Retrieve the start and end dates from the inputs
    const startDate = this.startDateInputTarget.value
    const endDate = this.endDateInputTarget.value

    // Calculate the number of days between the selected dates
    const days = this.#diffInDays(startDate, endDate)

    // Calculate the total price based on the number of days
    const totalValue = this.#totalValue(days)

    // Update the displayed price in the HTML
    this.#setPriceValue(totalValue)
  }

  // Set the priceHolder's inner text to the calculated value
  #setPriceValue(value) {
    this.priceHolderTarget.innerText = `${value}€`
  }

  // Calculate the difference in days between the two dates
  #diffInDays(startDate, endDate) {
    // Check if both dates are provided
    if (startDate && endDate) {
      // Calculate the difference in milliseconds
      const diffTime = Date.parse(endDate) - Date.parse(startDate)
      // Convert milliseconds to days
      const days = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
      // Return the number of days plus 1 (to include both start and end days)
      return days + 1
    } else {
      // If dates are not properly set, return 0
      return 0
    }
  }

  // Calculate the total price based on the number of days and the price per day
  #totalValue(days) {
    return days * this.priceValue
  }
}
