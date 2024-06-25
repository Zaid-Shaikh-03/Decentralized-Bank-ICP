import { eventNames } from "process";
import { DBank } from "../../declarations/DBank";

window.addEventListener("load", async function () {
  update();
});

document.querySelector("form").addEventListener("submit", async function (event) {
  event.preventDefault();

  const submitButton = event.target.querySelector("#submit-btn");
  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const outputAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  submitButton.setAttribute("disabled", true);

  if (document.getElementById("input-amount").value.length != 0) {
    await DBank.topUp(inputAmount);
  }

  if (document.getElementById("withdrawal-amount").value.length != 0) {
    await DBank.withdraw(outputAmount);
  }

  await DBank.compound();

  update();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";
  submitButton.removeAttribute("disabled");

})

async function update() {
  const currentAmount = await DBank.checkBalance();
  document.getElementById("value").innerText = currentAmount.toFixed(2);
}