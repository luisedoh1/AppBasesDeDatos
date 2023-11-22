document.addEventListener("DOMContentLoaded", (event) => {
    const form = document.querySelector(".menu");
    registerBtn = document.querySelector(".registerBtn");
    showBtn = document.querySelector(".showBtn");
    deleteBtn = document.querySelector(".deleteBtn");
    editBtn = document.querySelector(".editBtn");


    registerBtn.addEventListener("click", () => {
        window.location.href = "./register";
    });

    showBtn.addEventListener("click", (event) => {
      const clientId = showBtn.getAttribute('data-client-id'); // Make sure to add this data attribute in your EJS
      window.location.href = `./clients/${clientId}`;
    });

    deleteBtn.addEventListener("click", (event) => {
      const clientId = deleteBtn.getAttribute('data-client-id');
      if(confirm('Are you sure you want to delete this client?')) {
        fetch(`/clients/${clientId}/delete`, {
          method: 'POST'
        }).then(response => {
          // Handle response
          if(response.ok) {
            window.location.reload();
          }
        }).catch(error => {
          console.error('Error:', error);
        });
      }
    });

  const editButtons = document.querySelectorAll(".editBtn");

  editButtons.forEach(button => {
    button.addEventListener("click", () => {
      const clientId = button.getAttribute('data-client-id');
      window.location.href = `/clients/${clientId}/edit`;
    });
  });


});
