
function clipboardBtn() {
  const cb_btn = document.querySelectorAll(".share-btn");

    if(cb_btn.length > 0 ) {
      for (let i = 0; i < cb_btn.length; i++) {
        cb_btn[i].addEventListener("click", (event) => {

          if (typeof window.orientation !== "undefined" || navigator.userAgent.indexOf('IEMobile') !== -1) {
            console.log("this is a mobile");
              shareLink();
          } else {
            console.log("this is a desktop");
              updateClipboard();
          }
      });
    }
  }
}


function shareLink() {
  if (navigator.share) {
  navigator.share({
      title: 'Bar Roulette',
      url: '<%= request.original_url %>',
  })
    .then(() => console.log('Successful share'))
    .catch((error) => console.log('Error sharing', error));
}
}

function updateClipboard() {
  navigator.clipboard.writeText("<%= request.original_url %>").then(function() {
    console.log("successful")
  }, function() {
    console.log("failed");
  });
}

// tippy('#url-btn', {
//   arrow: true,
//   trigger: 'click',
//   content: 'Url copied to clipboard',
// })



export { clipboardBtn, shareLink, updateClipboard };