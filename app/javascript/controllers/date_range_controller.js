import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "startDate", "endDate"]

  connect() {
    // Set default values if not already set
    if (!this.startDateTarget.value) {
      const fiveDaysAgo = new Date();
      fiveDaysAgo.setDate(fiveDaysAgo.getDate() - 5);
      this.startDateTarget.value = this.formatDate(fiveDaysAgo);
    }
    
    if (!this.endDateTarget.value) {
      const today = new Date();
      this.endDateTarget.value = this.formatDate(today);
    }
  }

  filter() {
    this.formTarget.requestSubmit();
  }

  formatDate(date) {
    return date.toISOString().split('T')[0];
  }
}
