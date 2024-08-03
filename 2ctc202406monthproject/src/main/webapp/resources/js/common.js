document.addEventListener("DOMContentLoaded", function () {
    // 서브메뉴 표시/숨기기
    document.querySelectorAll(".menu-item > a").forEach(function (menuLink) {
        menuLink.addEventListener("click", function (e) {
            e.preventDefault();
            const submenu = this.nextElementSibling;
            if (submenu) {
                submenu.style.display = submenu.style.display === "block" ? "none" : "block";
            }
        });
    });

    // 정렬 초기화
    function initializeSort() {
        document.querySelectorAll(".sort-button").forEach(function (button) {
            button.addEventListener("click", function () {
                var table = this.closest("table");
                var tbody = table.querySelector("tbody");
                var rows = Array.from(tbody.querySelectorAll("tr"));
                var index = this.getAttribute("data-column");
                var ascending = this.classList.contains("asc");

                rows.sort(function (rowA, rowB) {
                    var cellA = rowA.querySelectorAll("td")[index].innerText;
                    var cellB = rowB.querySelectorAll("td")[index].innerText;
                    return ascending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
                });

                rows.forEach(function (row) {
                    tbody.appendChild(row);
                });

                this.classList.toggle("asc", !ascending);
                this.classList.toggle("desc", ascending);
            });
        });
    }

    initializeSort();
});
