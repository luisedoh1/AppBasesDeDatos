document.addEventListener("DOMContentLoaded", function() {
    const editForm = document.querySelector("form");

    function checkInputsFilled(inputs) {
        return Array.from(inputs).every(input => input.value.trim() !== "");
    }

    editForm.addEventListener("submit", function(event) {
        event.preventDefault();

        if (!editForm.checkValidity()) {
            alert("Please fill out all required fields correctly.");
            return;
        }

        const formInputs = document.querySelectorAll(".edit input");

        if (!checkInputsFilled(formInputs)) {
            alert("Please fill out all fields.");
            return;
        }

        const formData = {};
        formInputs.forEach(input => {
            formData[input.name] = input.value;
        });

        // Fetch request with JSON data
        fetch(editForm.action, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(formData),
        })
            .then(response => response.json())
            .then(data => {
                alert('Client updated successfully!');
            })
        window.location.href = '/';
    });
});
