document.addEventListener("DOMContentLoaded", function() {
        document.querySelector('.soojung').addEventListener('click', function () {
            var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
            if (selectedRows.length > 0) {
                selectedRows.forEach(function (checkbox) {
                    var row = checkbox.closest('tr');
                    row.querySelectorAll('.editable').forEach(function (cell) {
                        cell.querySelector('span').style.display = 'none';
                        cell.querySelector('input').style.display = 'inline-block';
                    });
                });
                document.querySelector('.OK').style.display = 'inline-block';
                this.style.display = 'none';
            } else {
                alert('수정할 항목을 선택하세요.');
            }
        });
        document.querySelector('.OK').style.display = 'inline-block';
        this.style.display = 'none';
    });

    document.querySelector('.OK').addEventListener('click', function (event) {
        var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
        if (selectedRows.length > 0) {
            var confirmed = confirm('수정하시겠습니까?');
            if (!confirmed) {
                event.preventDefault();
            }
        }
    });

    document.querySelector('.delete').addEventListener('click', function (event) {
        var selectedRows = document.querySelectorAll('tbody tr input.select-row:checked');
        if (selectedRows.length > 0) {
            var confirmed = confirm('정말 삭제하시겠습니까?');
            if (!confirmed) {
                event.preventDefault();
            }
        } else {
            alert('삭제할 항목을 선택하세요.');
            event.preventDefault();
        }
    });

    function filterTable(containerId, query) {
        var table = document.getElementById(containerId).querySelector("table");
        var rows = table.querySelectorAll("tbody tr");

        rows.forEach(function (row) {
            var cells = row.querySelectorAll("td");
            var match = Array.from(cells).some(function (cell) {
                return cell.innerText.toLowerCase().includes(query.toLowerCase());
            });
            row.style.display = match ? "" : "none";
        });
    }

