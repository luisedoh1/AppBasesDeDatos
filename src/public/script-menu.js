document.addEventListener("DOMContentLoaded", (event) => {
    const registerBtn = document.querySelector(".registerBtn");
    const showBtns = document.querySelectorAll(".showBtn"); // Changed to select all
    const deleteBtns = document.querySelectorAll(".deleteBtn"); // Changed to select all
    const editBtns = document.querySelectorAll(".editBtn"); // Changed to select all for consistency

    registerBtn.addEventListener("click", () => {
        window.location.href = "./register";
    });

    showBtns.forEach(showBtn => {
        showBtn.addEventListener("click", (event) => {
            const clientId = showBtn.getAttribute('data-client-id');
            window.location.href = `./clients/update/${clientId}`;
        });
    });

    deleteBtns.forEach(deleteBtn => {
        deleteBtn.addEventListener("click", (event) => {
            const clientId = deleteBtn.getAttribute('data-client-id');
            if (confirm('Are you sure you want to delete this client?')) {
                fetch(`/clients/delete/${clientId}`, {
                    method: 'POST'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    }
                }).catch(error => {
                    console.error('Error:', error);
                });
            }
        });
    });

    editBtns.forEach(editBtn => {
        editBtn.addEventListener("click", () => {
            const clientId = editBtn.getAttribute('data-client-id');
            window.location.href = `/clients/edit/${clientId}`;
        });
    });
});
