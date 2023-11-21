document.addEventListener('DOMContentLoaded', (event) => {
    const form = document.querySelector("form"),
        nextBtn = document.querySelector(".nextBtn"),
        submitBtn = document.querySelector(".submitBtn"),
        backBtn = document.querySelector(".backBtn");

    let registrationCompleted = false;

    function checkInputsFilled(inputs) {
        return Array.from(inputs).every(input => input.value.trim() !== "");
    }
    //Hola
    function submitAllData(registrationData, addressData) {
        fetch('http://localhost:3000/api/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(registrationData),
        })
            .then(response => response.json())
            .then(data => {
                return fetch('/api/address', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(addressData),
                });
            })
            .then(response => response.json())
            .then(data => {
                alert('Registration and address saved successfully!');
                // Here you can redirect to another page or reset the form
            })
            .catch(error => {
                console.error('Failed to save data:', error);
                alert("Failed to save data. Please try again.");
            });
    }

    nextBtn.addEventListener("click", (event) => {
        event.preventDefault();
        if (!registrationCompleted) {
            const registrationInputs = document.querySelectorAll(".first input");

            if (!checkInputsFilled(registrationInputs)) {
                alert("Please fill out all registration fields.");
                return;
            }

            registrationCompleted = true;
            form.classList.add('secActive');
        }
    });

    submitBtn.addEventListener("click", (event) => {
        event.preventDefault();

        if (!registrationCompleted) {
            alert("Please complete the registration first.");
            return;
        }

        const registrationInputs = document.querySelectorAll(".first input");
        const addressInputs = document.querySelectorAll(".second input");

        if (!checkInputsFilled(registrationInputs) || !checkInputsFilled(addressInputs)) {
            alert("Please fill out all fields.");
            return;
        }

        const registrationData = {};
        registrationInputs.forEach(input => {
            registrationData[input.name] = input.value;
        });

        const addressData = {};
        addressInputs.forEach(input => {
            addressData[input.name] = input.value;
        });

        submitAllData(registrationData, addressData);
    });

    backBtn.addEventListener("click", () => {
        if (registrationCompleted) {
            form.classList.remove('secActive');
            registrationCompleted = false;
        } else {
            alert("Back button clicked on registration form.");
        }
    });
});
