const initGiphy = () => {
  const wheelBtn = document.getElementById("address-form-submit");
  console.log(wheelBtn);
  const homeContainer = document.getElementById("home-container");
  const giphyContainer = document.getElementById("giphy-container");


  wheelBtn.addEventListener("click", (event) => {
    homeContainer.style.display = "none";
    giphyContainer.style.display = "block";
  });
};

export { initGiphy };
