document.addEventListener('DOMContentLoaded', (event) => {
    const form = document.querySelector("form"),
        nextBtn = document.querySelector(".nextBtn"),
        addressBtn = document.querySelector(".submitBtn"),
        backBtn = document.querySelector(".backBtn");

    let registrationCompleted = false;

    function checkInputsFilled(inputs) {
        return Array.from(inputs).every(input => input.value.trim() !== "");
    }

    function submitAddress(addressData) {
        fetch('/api/address', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(addressData),
        })
            .then(response => response.json())
            .then(data => {
                alert('Address saved successfully!');
            })
            .catch(error => {
                console.error('Failed to save address:', error);
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

            const registrationData = {};
            registrationInputs.forEach(input => {
                registrationData[input.name] = input.value;
            });

            fetch('http://localhost:3000/api/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(registrationData),
            })
                .then(response => response.json())
                .then(data => {
                    alert("Registration successful!");
                    registrationCompleted = true;
                    form.classList.add('secActive');
                })
                .catch(error => {
                    console.error('Registration failed:', error);
                    alert("Failed to register. Please try again.");
                });
        }else{
            form.classList.add('secActive');
        }
    });

    addressBtn.addEventListener("click", (event) => {
        event.preventDefault();

        if (!registrationCompleted) {
            alert("Please complete the registration first.");
            return;
        }

        const addressInputs = document.querySelectorAll(".second input");

        if (!checkInputsFilled(addressInputs)) {
            alert("Please fill out all address fields.");
            return;
        }

        const addressData = {};
        addressInputs.forEach(input => {
            addressData[input.name] = input.value;
        });

        submitAddress(addressData);
    });

    backBtn.addEventListener("click", () => {
        if (registrationCompleted) {
            form.classList.remove('secActive');
        } else {
            alert("Back button clicked on registration form.");
        }
    });
});