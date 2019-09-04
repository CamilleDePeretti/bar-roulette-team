const showFilters = () => {
  const filterBox = document.querySelector(".filter-box");
  const filterBtn = document.querySelector("#filter-btn");
  const filters = document.querySelectorAll(".filter-box a");
  const filterInput = document.querySelector("#bar-filters");

  if (filterBox != null) {
    console.log("filter box isn't null!");
    filterBtn.addEventListener("click", (event) => {
      filterBox.classList.toggle("filter-box-hide");
    });

    for(let i = 0; i < filters.length; i++) {
      filters[i].addEventListener("click", (event) => {
        filterBox.classList.toggle("filter-box-hide");
        filterInput.value = filters[i].innerText.toLowerCase();
        console.log(filterInput.value);
      });
    }
  }
}


export { showFilters };
