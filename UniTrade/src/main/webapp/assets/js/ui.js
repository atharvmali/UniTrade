document.addEventListener("DOMContentLoaded", function () {
    document.body.classList.add("page-ready");

    const currentPage = window.location.pathname.split("/").pop();
    const links = document.querySelectorAll(".navbar a");

    links.forEach(function (link) {
        const linkPage = link.getAttribute("href");

        if (linkPage && linkPage.indexOf(currentPage) !== -1) {
            link.classList.add("active-link");
        }
    });

    const cards = document.querySelectorAll(".card");

    cards.forEach(function (card) {
        card.addEventListener("mouseenter", function () {
            card.classList.add("card-focus");
        });

        card.addEventListener("mouseleave", function () {
            card.classList.remove("card-focus");
        });
    });
});
