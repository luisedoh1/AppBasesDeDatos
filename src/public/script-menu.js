document.addEventListener("DOMContentLoaded", (event) => {
  const form = document.querySelector("menu"),
    registerBtn = document.querySelector(".registerBtn");

  registerBtn.addEventListener("click", () => {
    window.location.href = "./register";
  });
});
