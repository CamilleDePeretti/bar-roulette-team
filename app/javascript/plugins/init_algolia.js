import places from 'places.js';

const initAlgolia = () => {
  const addressInput = document.querySelectorAll('.address-input');
  if (addressInput.length > 0) {
    for (let i = 0; i < addressInput.length; i++)
    {
      places({ container: addressInput[i] });
    }
  }
}

export { initAlgolia };
