import { initAlgolia } from '../plugins/init_algolia';

const howMany = () => {
   return document.querySelectorAll(".address-input").length
}

const inputs = () => {
  return document.querySelectorAll(".address-input");
}

const generateCode = (amnt) => {
  let code = "";

  let value = [];

  for (let i = 0; i < amnt; i ++) {
    if(inputs()[i] != null)
      value.push(inputs()[i].value);
    else
      value.push("");
  }

  // console.log(value);

  for (let i = 0; i < amnt; i++) {
    code += `<input name='addresses[]' type='text' class='address-input' value ='${value[i]}' placeholder='Type address here'/>`;
  }

  return code;
}

const dynamicForm = () => {
  const add = document.querySelector("#add-address-btn");
  const remove = document.querySelector("#remove-address-btn");
  const form = document.querySelector("#address-form");

  if(add != null) {
    add.addEventListener("click", (event) => {
      let amnt = howMany() + 1;
      form.innerHTML = generateCode(amnt);
      initAlgolia();
    });

    remove.addEventListener("click", (event) => {
      if(howMany() > 1) {
        let amnt = howMany() - 1;
        form.innerHTML = generateCode(amnt);
        initAlgolia();
      }
    });
  }
}

export { dynamicForm };
