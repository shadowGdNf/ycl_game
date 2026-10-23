"use strict";
const statusElement = document.querySelector("#status");
const button = document.querySelector("#counter");
let count = 0;
button.addEventListener("click", () => {
  count += 1;
  button.textContent = `点击计数：${count}`;
});
fetch("assets/config.json")
  .then((response) => {
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    return response.json();
  })
  .then((config) => {
    statusElement.textContent = config.message;
    button.disabled = false;
  })
  .catch((error) => {
    statusElement.textContent = `资源加载失败：${error.message}`;
  });
