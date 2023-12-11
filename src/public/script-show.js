document.addEventListener("DOMContentLoaded", (event) => {
    const form = document.querySelector("form");
    homeBtn = document.querySelector(".homeBtn");

    homeBtn.addEventListener("click", (event) => {
        event.preventDefault();
        window.location.href = "/";
    });
});
