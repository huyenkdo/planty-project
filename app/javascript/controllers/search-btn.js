document.addEventListener('DOMContentLoaded', function() {
  const filterButtons = document.querySelectorAll('.filter-btn');
  const plantCards = document.querySelectorAll('.card-index');

  filterButtons.forEach(button => {
    button.addEventListener('click', function() {
      const filter = this.getAttribute('data-filter');
      console.log('Filter:', filter);
      filterPlants(filter);
    });
  });

  function filterPlants(filter) {
    plantCards.forEach(card => {
      const category = card.getAttribute('data-category');
      console.log('Category:', category);
      if (filter === 'all' || category === filter) {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    });
  }
});
