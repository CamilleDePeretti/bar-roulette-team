const initGif = () => {
  const wheelBtn = document.getElementById("address-form-submit");
  console.log(wheelBtn);
  const homeContainer = document.getElementById("home-container");
  const gifContainer = document.getElementById("gif-container");


  if (wheelBtn) {
    wheelBtn.addEventListener("click", (event) => {
      homeContainer.style.display = "none";
      // gifContainer.removeAttribute("style");
    });
  }
};

export { initGif };
