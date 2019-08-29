// When I click on the wheel button
// <iframe src="https://giphy.com/embed/Nd2hAfzpUhzJVrAnPN" width="480" height="360" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/julesm-julesmumm-psycheledic-Nd2hAfzpUhzJVrAnPN">via GIPHY</a></p>

// the home page disappear

//for 5 sec

//redircets to show page


const initGiphy = () => {
  const wheelBtn = document.getElementById("address-form-submit");
  console.log(wheelBtn);
  const homeContainer = document.getElementById("home-container");
  const giphyContainer = document.getElementById("giphy-container");


  wheelBtn.addEventListener("click", (event) => {
    homeContainer.style.display = "none";
    giphyContainer.style.display = "block";
    wheelBtn.click();
  });
};

export { initGiphy };
